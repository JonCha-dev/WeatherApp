//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Jon Chang on 6/25/23.
//

import Foundation
import Combine

class WeatherService {
    
    var cancellable = Set<AnyCancellable>()
    let geoString = "https://api.openweathermap.org/geo/1.0/direct?q="
    let dataString = "https://api.openweathermap.org/data/2.5/weather?lat="
    let dataEndString = "&lon="
    let apiKey = "&appid=808323f96065ecb2afd950a6b9db05d6"
    let imperial = "&units=imperial"
    
    func fetchWeather(_ geoLoc: GeoResponse) -> Future<WeatherResponse, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            let finalUrlString = self.dataString + "\(geoLoc.lat)" + self.dataEndString + "\(geoLoc.lon)" + self.apiKey + self.imperial
            guard let url = URL(string: finalUrlString) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data } // Data
                .decode(type: WeatherResponse.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in // subscribing to events coming from publisher
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &self.cancellable)
        }
    }
    
    func fetchGeo(_ searchText: String) -> Future<[GeoResponse], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            let finalUrlString = self.geoString + searchText + self.apiKey
            guard let url = URL(string: finalUrlString) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data } // Data
                .decode(type: [GeoResponse].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in // subscribing to events coming from publisher
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &self.cancellable)
        }
    }
}
