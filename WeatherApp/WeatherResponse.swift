//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Jon Chang on 6/25/23.
//

import Foundation

struct WeatherResponse: Decodable, Identifiable {
    let id:Int
    let weather:[Weather]
    let main:MainWeather
    let dt:Double
    let name:String
}

struct GeoResponse: Decodable {
    let lat:Double
    let lon:Double
}

struct Weather: Decodable {
    let main:String
    let description:String
    let icon:String
}

struct MainWeather: Decodable {
    let temp:Float
    let temp_min:Float
    let temp_max:Float
    let pressure:Int
    let humidity:Int
}

