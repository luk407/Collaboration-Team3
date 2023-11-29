//
//  AirQualityViewModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//
import GenericNetworkLayer
import Foundation

protocol AirQualityViewModelDelegate: AnyObject {
    func pollutionInfoFetched(with: Pollution)
}

final class AirQualityViewModel {
    private var urlString: String?
    
    private var cityPollution: Pollution?
    
    weak var delegate: AirQualityViewModelDelegate?
    
    func requestPollutionInfo(with cityName: String) {
        fetchPollutionInfo(with: cityName)
    }
    
    private func fetchPollutionInfo(with cityName: String) {
        urlString = "https://api.airvisual.com/v2/city?city=\(cityName)&state=California&country=USA&key=a3100532-b4b4-4c82-a181-a3ff5affacde#"
        
        Network().request(with: URL(string: urlString!)!) { [weak self] (result: Result<Pollution, Error>) in
            switch result {
            case .success(let info):
                self?.cityPollution = info
                self?.delegate?.pollutionInfoFetched(with: info)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
