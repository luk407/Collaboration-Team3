//
//  PopulationModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//

import Foundation

// Mark: - CountryModel
struct CountryModel: Decodable {
    let countries: [String]
}

// MARK: - PopulationResultModel
struct PopulationResponse: Decodable {
    let totalPopulation: TotalPopulation

    enum CodingKeys: String, CodingKey {
        case totalPopulation = "total_population"
    }
}

// MARK: - TotalPopulation
struct TotalPopulation: Decodable {
    let date: String
    let population: Int
}
