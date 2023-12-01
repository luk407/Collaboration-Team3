//
//  WeatherModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//

import Foundation

struct WeatherResponse: Decodable {
    let list: [List]
    let city: WeatherCity
}

struct WeatherCity: Decodable {
    let name: String
    let country: String
}

struct List: Decodable {
    let weather: [Weather]
}

struct Weather: Decodable {
    let main, description: String
}
