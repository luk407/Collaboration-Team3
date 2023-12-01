//
//  SpeciesViewModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//  Modified by Eka Kelenjeridze on 30.11.23.
//

import UIKit
import GenericNetworkLayer

protocol SpeciesViewModelDelegate: AnyObject {
    func speciesFetched(_ species: [Specie])
//    func specieImageFetched(_ image: UIImage)
    func showError(_ error: Error)
}

final class SpeciesViewModel {
    private var cityID: Int
    private let networkManager: NetworkService
    
    weak var delegate: SpeciesViewModelDelegate?
    
    init(cityID: Int, networkManager: NetworkService) {
        self.cityID = cityID
        self.networkManager = networkManager
    }
    
    // MARK: - ViewLifeCycle
    func viewDidLoad() {
        fetchSpecieDetails(with: 10616)
    }
    
    private func fetchSpecieDetails(with cityID: Int) {
        let baseURL = "https://api.inaturalist.org/v1/observations/species_counts"
        let endpoint = "?place_id="
        let urlString = "\(baseURL)\(endpoint)\(cityID)"
        
        guard let speciesURL = URL(string: urlString) else { return }
        networkManager.request(with: speciesURL) { [weak self] (result: Result<SpeciesResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.speciesFetched(response.results)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
    
//    private func fetchImage(from url: String) {
//        Network().downloadImage(from: url) { [weak self] image in
//            self?.delegate?.specieImageFetched(image ?? UIImage())
//        }
//    }
}

