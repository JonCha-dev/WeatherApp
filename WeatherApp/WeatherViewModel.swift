//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Jon Chang on 6/25/23.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var data = [WeatherResponse]()
    
    var cancellable = Set<AnyCancellable>()
    let service = WeatherService()
    
    func getWeather(_ search: String) {
        getGeo(search)
    }
    
    private func getWeatherData(_ geoLoc: [GeoResponse]) {
        if geoLoc.count > 0 {
            service.fetchWeather(geoLoc[0])
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        print(String(describing: err))
                    }
                } receiveValue: { [weak self] data in
                    self?.data = [data]
                }
                .store(in: &cancellable)
        }
    }
    
    private func getGeo(_ search: String) {
        service.fetchGeo(search)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                self?.getWeatherData(data)
            }
            .store(in: &cancellable)
    }
}
