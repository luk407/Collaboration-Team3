//
//  WeatherViewModel.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//

import GenericNetworkLayer
import Foundation

//MARK: - Protocols
protocol WeatherViewModelDelegate: AnyObject {
    func weatherInfoFetched(response: WeatherResponse)
}

final class WeatherViewModel {
    
    //MARK: Properties
    weak var delegate: WeatherViewModelDelegate?
    
    //MARK: - Methods
    func requestWeatherInfo(lat: Double, long: Double) {
        fetchWeatherInfo(lat: lat, long: long)
    }
    
    private func fetchWeatherInfo(lat: Double, long: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=94fba9948553f86e11e18f2f181314ba") else { return }
        
        NetworkManager().request(with: url) { [ weak self ] (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.weatherInfoFetched(response: response)
            case .failure(let failure):
                print(failure)
                break
            }
            
        }
    }
}
