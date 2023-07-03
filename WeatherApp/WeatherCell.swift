//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Jon Chang on 6/25/23.
//

import SwiftUI

struct WeatherCell: View {
    let weather: [WeatherResponse]
    
    var body: some View {
        ZStack {
            ForEach(weather) { data in
                VStack {
                    HStack{
                        VStack(alignment: .leading) {
                            Text(data.name)
                                .font(.system(size: 25))
                                .bold()
                            Text(getTimeString(data.dt))
                        }
                        Spacer()
                        Text(String(format: "%.2f", data.main.temp) + "°F")
                            .font(.system(size:25))
                            .bold()
                    }
                    Spacer()
                    HStack{
                        Text(data.weather[0].main)
                        getImage(data.weather[0].icon)
                        Spacer()
                        Text("H: " + String(format: "%.2f", data.main.temp_max) + "°F")
                            .bold()
                        Text("L: " + String(format: "%.2f", data.main.temp_min) + "°F")
                            .bold()
                    }
                }
                .padding()
                .frame(width: 375, height:175)
                .background(Color.yellow)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 4)
                )
            }
        }
    }
    
    private func getTimeString(_ dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    private func getImage(_ icon: String) -> some View {

        let img = "https://openweathermap.org/img/w/\(icon).png"
        
        return AsyncImage(url: URL(string: img)) { image in
            image
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode:.fit)
                .cornerRadius(10)
        } placeholder: {
            Image(systemName: "photo")
        }
    }
}

 

struct WeatherCell_Previews: PreviewProvider {
    static let mockData = WeatherResponse(id: 123,
        weather: [Weather(main: "Clouds", description: "few clouds", icon: "02d")],
        main: MainWeather(temp: 69.1, temp_min: 54.61, temp_max: 80.64, pressure: 1014, humidity: 62),
        dt: 1687984724,
        name: "Fremont")
    
    static var previews: some View {
        WeatherCell(weather: [mockData])
    }
}

