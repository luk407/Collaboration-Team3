//
//  ViewController.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//

import UIKit

final class AirQualityViewController: UIViewController {

    //MARK: - Properties
    private let mainStackView = UIStackView()
    
    private let cityNameLabel = UILabel()
    
    private let aqiusLabel = UILabel()
    
    private let aqicnLabel = UILabel()
    
    private let qualityImageView = UIImageView()
    
    private var qualityLabel = UILabel()
    
    private let searchController = UISearchController()
    
    var cityName: String?
    
    private let airQualityViewModel = AirQualityViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setupConstraints()
        setupUI()
        setupAirQualityViewModelDelegate()
    }

    //MARK: Setup Methods
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(cityNameLabel)
        mainStackView.addArrangedSubview(aqiusLabel)
        mainStackView.addArrangedSubview(aqicnLabel)
        mainStackView.addArrangedSubview(qualityLabel)
        mainStackView.addArrangedSubview(qualityImageView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupCityNameLabelConstraints()
        setupAqiusLabelConstraints()
        setupAqicnLabelConstraints()
        setupQualityLabelConstraints()
        setupQualityImageViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupCityNameLabelUI()
        setupAqiusLabelUI()
        setupAqicnLabelUI()
        setupQualityLabelUI()
        setupNavigationBarUI()
        setupQualityImageViewUI()
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupCityNameLabelConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupAqiusLabelConstraints() {
        NSLayoutConstraint.activate([
            aqiusLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            aqiusLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            aqiusLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupAqicnLabelConstraints() {
        NSLayoutConstraint.activate([
            aqicnLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            aqicnLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            aqicnLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupQualityLabelConstraints() {
        NSLayoutConstraint.activate([
            qualityLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            qualityLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            qualityLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupQualityImageViewConstraints() {
        NSLayoutConstraint.activate([
            qualityImageView.widthAnchor.constraint(equalToConstant: 200),
            qualityImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupAirQualityViewModelDelegate() {
        airQualityViewModel.delegate = self
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
    }
    private func setupCityNameLabelUI() {
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cityNameLabel.textAlignment = .left
        cityNameLabel.text = "City"
    }
    
    private func setupAqiusLabelUI() {
        aqiusLabel.font = UIFont.systemFont(ofSize: 20)
        aqiusLabel.textAlignment = .left
        aqiusLabel.text = "AQIUS: 0"
    }
    
    private func setupAqicnLabelUI() {
        aqicnLabel.font = UIFont.systemFont(ofSize: 20)
        aqicnLabel.textAlignment = .left
        aqicnLabel.text = "AQICN: 0"
    }
    
    private func setupQualityLabelUI() {
        qualityLabel.font = UIFont.boldSystemFont(ofSize: 15)
        qualityLabel.textAlignment = .center
        qualityLabel.text = "Quality"
    }
    
    private func setupQualityImageViewUI() {
        qualityImageView.image = UIImage(systemName: "circle")
        qualityImageView.contentMode = .scaleAspectFit
    }
    
    private func setupNavigationBarUI() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.placeholder = "Type the name of a city..."
        searchController.searchBar.isTranslucent = false
    }
    
    private func startFetching() {
        airQualityViewModel.requestPollutionInfo(with: cityName!)
    }
}


//MARK: - Extensions
extension AirQualityViewController: UISearchBarDelegate {
    
}

extension AirQualityViewController: UISearchControllerDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        cityName = searchBar.text
        startFetching()
    }
}

extension AirQualityViewController: AirQualityViewModelDelegate {
    func pollutionInfoFetched(with cityPollution: DataClass) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = cityPollution.city
            self.aqiusLabel.text = "AQIUS: \(String(cityPollution.current.pollution.aqius))"
            self.aqicnLabel.text = "AQICN: \(String(cityPollution.current.pollution.aqicn))"
            
            if cityPollution.current.pollution.aqius <= 50 { // example: san diego
                self.qualityLabel.text = "Quality: Good"
                self.qualityImageView.image = UIImage(named: "Good")?.withTintColor(UIColor.green)
            } else if cityPollution.current.pollution.aqius > 50 && cityPollution.current.pollution.aqius <= 100 { // example: sacramento
                self.qualityLabel.text = "Quality: Moderate"
                self.qualityImageView.image = UIImage(named: "Moderate")?.withTintColor(UIColor.cyan)
            } else if cityPollution.current.pollution.aqius > 100 && cityPollution.current.pollution.aqius <= 150 {
                self.qualityLabel.text = "Quality: Unhealthy for Sensitive Groups"
                self.qualityImageView.image = UIImage(named: "Unhealthyfor")?.withTintColor(UIColor.yellow)
            } else if cityPollution.current.pollution.aqius > 150 && cityPollution.current.pollution.aqius <= 200 {
                self.qualityLabel.text = "Quality: Unhealthy"
                self.qualityImageView.image = UIImage(named: "Unhealthy")?.withTintColor(UIColor.orange)
            } else if cityPollution.current.pollution.aqius > 200 && cityPollution.current.pollution.aqius <= 300 {
                self.qualityLabel.text = "Quality: Very Unhealthy"
                self.qualityImageView.image = UIImage(named: "VeryUnhealthy")?.withTintColor(UIColor.red)
            } else if cityPollution.current.pollution.aqius > 300 {
                self.qualityLabel.text = "Quality: Hazardous"
                self.qualityImageView.image = UIImage(named: "Hazardous")?.withTintColor(UIColor.black)
            }
            
        }
    }
}
