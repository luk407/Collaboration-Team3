//
//  AirQualityViewModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//

import GenericNetworkLayer
import Foundation

protocol AirQualityViewModelDelegate: AnyObject {
    func pollutionInfoFetched(with: DataClass)
}

final class AirQualityViewModel {
    
    weak var delegate: AirQualityViewModelDelegate?
    
    func requestPollutionInfo(with cityName: String) {
        fetchPollutionInfo(with: cityName)
    }
    
    private func fetchPollutionInfo(with cityName: String) {
        guard let url = URL(string: "https://api.airvisual.com/v2/city?city=\(cityName)&state=California&country=USA&key=a3100532-b4b4-4c82-a181-a3ff5affacde#") else { return }
        
        NetworkManager().request(with: url) { [weak self] (result: Result<PollutionResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.pollutionInfoFetched(with: response.data)
            case .failure(let failure):
                break
            }
        }
    }
}
