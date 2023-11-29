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
            cityNameLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupAqiusLabelConstraints() {
        NSLayoutConstraint.activate([
            aqiusLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            aqiusLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            aqiusLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupAqicnLabelConstraints() {
        NSLayoutConstraint.activate([
            aqicnLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            aqicnLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            aqicnLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - UI
    private func setupCityNameLabelUI() {
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cityNameLabel.textAlignment = .center
    }
    
    private func setupAqiusLabelUI() {
        aqiusLabel.font = UIFont.systemFont(ofSize: 20)
        aqiusLabel.textAlignment = .left
    }
    
    private func setupAqicnLabelUI() {
        aqicnLabel.font = UIFont.systemFont(ofSize: 20)
        aqicnLabel.textAlignment = .left
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
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        cityName = searchText
////        print(searchText)
////        airQualityViewModel.requestPollutionInfo(with: cityName ?? "")
//    }
//    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        cityName = searchBar.text
//        print(searchBar.text!)
//        airQualityViewModel.requestPollutionInfo(with: cityName ?? "")
//    }
}

extension AirQualityViewController: UISearchControllerDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        cityName = searchBar.text
        startFetching()
    }
}

extension AirQualityViewController: AirQualityViewModelDelegate {
    func pollutionInfoFetched(with cityPollution: Pollution) {
        cityNameLabel.text = cityName
        aqiusLabel.text = String(cityPollution.aqius)
        aqicnLabel.text = String(cityPollution.aqicn)
    }
}
