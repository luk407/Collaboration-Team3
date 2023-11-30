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
    
    private let searchBar = UISearchBar()
    
    private let searchController = UISearchController()
    
    private var pollutionForCity: Pollution?
    
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
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupCityNameLabelConstraints()
        setupAqiusLabelConstraints()
        setupAqicnLabelConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupCityNameLabelUI()
        setupAqiusLabelUI()
        setupAqicnLabelUI()
        setupNavigationBarUI()
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
        aqiusLabel.text = "AQIUI: 0"
    }
    
    private func setupAqicnLabelUI() {
        aqicnLabel.font = UIFont.systemFont(ofSize: 20)
        aqicnLabel.textAlignment = .left
        aqicnLabel.text = "AQICN: 0"
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
    func pollutionInfoFetched(with cityPollution: Pollution) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = self.cityName
            self.aqiusLabel.text = "AQIUS: \(String(cityPollution.aqius))"
            self.aqicnLabel.text = "AQIUS: \(String(cityPollution.aqicn))"
        }
    }
}
