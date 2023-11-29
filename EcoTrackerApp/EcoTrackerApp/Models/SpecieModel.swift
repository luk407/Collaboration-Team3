//
//  SpecieModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//  Modified by Eka Kelenjeridze on 29.11.23.
//

import Foundation

// MARK: - CityID Model
struct CityID: Decodable {
    let results: [Result]
    
    struct Result: Codable {
        let id: Int
    }
}

// MARK: - Species Model
struct Species: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let taxon: Taxon
}

struct Taxon: Decodable {
    let name: String
    let defaultPhoto: DefaultPhoto
    let wikipediaURL: String?
    
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
