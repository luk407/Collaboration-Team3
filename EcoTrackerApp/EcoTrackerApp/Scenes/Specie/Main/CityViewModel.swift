//
//  DetailsViewModel.swift
//  EcoTrackerApp
//
//  Created by Eka Kelenjeridze on 30.11.23.
//

import Foundation
import GenericNetworkLayer

protocol CityViewModelDelegate: AnyObject {
    func citiesFetched(_ cities: [City])
    func navigateToSpecieDetails(with cityID: Int)
    func showError(_ error: Error)
}

final class CityViewModel {
    // MARK: - Properties
    private var cities: [City]? = nil
    private let networkManager: NetworkService
    
    weak var delegate: CityViewModelDelegate?
    
    // MARK: - Init
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    // MARK: - ViewLifeCycle
    func viewDidLoad() {
        citiesFetched(with: "")
    }
    
    // MARK: - Methods
    func didSelectCity(at indexPath: IndexPath) {
        if let cityID = cities?[indexPath.row].id {
            delegate?.navigateToSpecieDetails(with: cityID)
        }
    }
    
    func citiesFetched(with cityName: String) {
        let baseURL = "https://api.inaturalist.org/"
        let endpoint = "v1/places/autocomplete?q="
        let urlString = "\(baseURL)\(endpoint)\(cityName)"
        print(urlString)
        
        guard let cityIdUrl = URL(string: urlString) else {
            delegate?.showError(NetworkError.error(error: Error.self as! Error))
            return
        }
        
        networkManager.request(with: cityIdUrl) { [weak self] (result: Result<CityIDResponse, Error>) in
            switch result {
            case .success(let response):
                let fetchedCities = response.results
                self?.cities = fetchedCities
                self?.delegate?.citiesFetched(fetchedCities)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
