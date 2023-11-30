//
//  SpecieModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//  Modified by Eka Kelenjeridze on 29.11.23.
//

import Foundation

// MARK: - CityID Model
struct CityIDResponse: Decodable {
    let results: [City]
}

struct City: Codable {
    let name: String
    let id: Int
}

// MARK: - Species Model
struct SpeciesResponse: Decodable {
    let results: [Specie]
}

struct Specie: Decodable {
    let taxon: SpecieDetails
}

struct SpecieDetails: Decodable {
    let name: String
    let defaultPhoto: DefaultPhoto
    let wikipediaURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case defaultPhoto = "default_photo"
        case wikipediaURL = "wikipedia_url"
    }
}

struct DefaultPhoto: Decodable {
    let mediumURL: String
    let attribution: String
    
    enum CodingKeys: String, CodingKey {
        case mediumURL = "medium_url"
        case attribution
    }
}
