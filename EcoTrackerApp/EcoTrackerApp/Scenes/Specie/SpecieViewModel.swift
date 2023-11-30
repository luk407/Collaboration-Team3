//
//  SpecieViewModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//  Modified by Eka Kelenjeridze on 30.11.23.
//

import Foundation
import GenericNetworkLayer

protocol SpecieViewModelDelegate: AnyObject {
    func cityIDFetched(_ cityID: Int)
    func speciesFetched(_ species: [SpecieDetails])
    func showError(_ error: Error)
}

final class SpecieViewModel {
    private let networkManager: NetworkService

    weak var delegate: SpecieViewModelDelegate?

    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }

    func fetchCityID(with cityName: String) {
        let baseURL = "https://api.inaturalist.org/"
        let endpoint = "v1/places/autocomplete?q="
        let urlString = "\(baseURL)+\(endpoint)+\(cityName)"
        
        guard let cityIdUrl = URL(string: urlString) else {
            delegate?.showError(NetworkError.error(error: Error.self as! Error))
            return
        }
        
        networkManager.request(with: cityIdUrl) { [weak self] (result: Result<CityIDResponse, Error>) in
            switch result {
            case .success(let response):
                guard let firstResult = response.results.first else {
                    self?.delegate?.showError(NetworkError.error(error: Error.self as! Error))
                    return
                }
                self?.delegate?.cityIDFetched(firstResult.id)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }

    
    private func fetchSpecieDetails(with cityID: Int) {
        let baseURL = "https://api.inaturalist.org/v1/observations/species_counts"
        let endpoint = "?place_id="
        let urlString = "\(baseURL)+\(endpoint)+\(cityID)"


        guard let speciesURL = URL(string: urlString) else { return }
        networkManager.request(with: speciesURL) { [weak self] (result: Result<SpeciesResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.speciesFetched(response.results.map { $0.taxon })
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}


