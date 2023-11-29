//
//  AirQualityModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//

import Foundation

struct PollutionResponse: Decodable {
    let pollution: Pollution
}

struct Pollution: Decodable {
    let aqius: Int
    let aqicn: Int
}


