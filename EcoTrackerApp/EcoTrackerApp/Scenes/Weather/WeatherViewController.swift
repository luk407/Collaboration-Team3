//
//  WeatherViewController.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//  Modified by Eka Kelenjeridze on 29.11.23.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    private let mainStackView = UIStackView()
    
    private let latTextField = UITextField()
    
    private let longTextField = UITextField()
    
    private let showWeatherButton = UIButton()
    
    private let fetchedFactsStackView = UIStackView()
    
    private var countryLabel = UILabel()
    
    private var cityLabel = UILabel()
    
    private var weatherMainLabel = UILabel()
    
    private var weatherDescriptionLabel = UILabel()
    
    private let weatherViewModel = WeatherViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBackgroundColor()
        addSubViews()
        setupConstraints()
        setupUI()
        setupWeatherViewModelDelegate()
    }
    
    //MARK: Setup Methods
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(latTextField)
        mainStackView.addArrangedSubview(longTextField)
        mainStackView.addArrangedSubview(showWeatherButton)
        mainStackView.addArrangedSubview(fetchedFactsStackView)
        fetchedFactsStackView.addArrangedSubview(countryLabel)
        fetchedFactsStackView.addArrangedSubview(cityLabel)
        fetchedFactsStackView.addArrangedSubview(weatherMainLabel)
        fetchedFactsStackView.addArrangedSubview(weatherDescriptionLabel)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupLatTextFieldConstraints()
        setupLongTextFieldConstraints()
        setupShowWeatherButtonConstraints()
        setupFetchedFactsStackViewConstraints()
        setupCountryLabelConstraints()
        setupCityLabelConstraints()
        setupWeatherMainLabelConstraints()
        setupWeatherDescriptionLabelConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupLatTextFieldUI()
        setupLongTextFieldUI()
        setupShowWeatherButtonUI()
        setupFetchedFactsStackViewUI()
        setupCountryLabelUI()
        setupCityLabelUI()
        setupWeatherMainLabelUI()
        setupWeatherDescriptionLabelUI()
    }
    
    //MARK: - Methods
    private func showWeatherButtonClicked() {
        guard let latDouble = Double(latTextField.text!) else { return }
        guard let longDouble = Double(longTextField.text!) else { return }
        
        weatherViewModel.requestWeatherInfo(lat: latDouble, long: longDouble)
    }
    
    //MARK: - Setup Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupLatTextFieldConstraints() {
        NSLayoutConstraint.activate([
            latTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            latTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            latTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupLongTextFieldConstraints() {
        NSLayoutConstraint.activate([
            longTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            longTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            longTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupShowWeatherButtonConstraints() {
        NSLayoutConstraint.activate([
            showWeatherButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            showWeatherButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            showWeatherButton.widthAnchor.constraint(equalToConstant: 100),
            showWeatherButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupFetchedFactsStackViewConstraints() {
        NSLayoutConstraint.activate([
            fetchedFactsStackView.heightAnchor.constraint(equalToConstant: 250),
            fetchedFactsStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            fetchedFactsStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func setupCountryLabelConstraints() {
        NSLayoutConstraint.activate([
            countryLabel.leadingAnchor.constraint(equalTo: fetchedFactsStackView.leadingAnchor, constant: 10),
            countryLabel.trailingAnchor.constraint(equalTo: fetchedFactsStackView.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupCityLabelConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: fetchedFactsStackView.leadingAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: fetchedFactsStackView.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupWeatherMainLabelConstraints() {
        NSLayoutConstraint.activate([
            weatherMainLabel.leadingAnchor.constraint(equalTo: fetchedFactsStackView.leadingAnchor, constant: 10),
            weatherMainLabel.trailingAnchor.constraint(equalTo: fetchedFactsStackView.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupWeatherDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: fetchedFactsStackView.leadingAnchor, constant: 10),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: fetchedFactsStackView.trailingAnchor, constant: -10),
        ])
    }
    
    //MARK: - Private Methods
    
    private func setupViewBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
    }
    
    private func setupLatTextFieldUI() {
        latTextField.textAlignment = .left
        latTextField.placeholder = "Type Latitude"
        latTextField.borderStyle = .roundedRect
    }
    
    private func setupLongTextFieldUI() {
        longTextField.textAlignment = .left
        longTextField.placeholder = "Type Longitude"
        longTextField.borderStyle = .roundedRect
    }
    
    private func setupShowWeatherButtonUI() {
        showWeatherButton.setTitleColor(.black, for: .normal)
        showWeatherButton.setTitle("Show Weather", for: .normal)
        showWeatherButton.layer.cornerRadius = 8
        showWeatherButton.layer.backgroundColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 0.3).cgColor
        showWeatherButton.addAction(UIAction(handler: { [ weak self] action in
            self?.showWeatherButtonClicked()
        }), for: .touchUpInside)
    }
    
    private func setupFetchedFactsStackViewUI() {
        fetchedFactsStackView.axis = .vertical
        fetchedFactsStackView.spacing = 10
        fetchedFactsStackView.alignment = .center
        fetchedFactsStackView.distribution = .fillProportionally
        fetchedFactsStackView.layer.backgroundColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 0.3).cgColor
        fetchedFactsStackView.layer.cornerRadius = 8
    }
    
    private func setupCountryLabelUI() {
        countryLabel.font = UIFont.boldSystemFont(ofSize: 25)
        countryLabel.textAlignment = .left
        countryLabel.text = "Country"
    }
    
    private func setupCityLabelUI() {
        cityLabel.font = UIFont.boldSystemFont(ofSize: 25)
        cityLabel.textAlignment = .left
        cityLabel.text = "City"
    }
    
    private func setupWeatherMainLabelUI() {
        weatherMainLabel.font = UIFont.boldSystemFont(ofSize: 25)
        weatherMainLabel.textAlignment = .left
        weatherMainLabel.text = "Weather"
        weatherMainLabel.numberOfLines = 0
    }
    
    private func setupWeatherDescriptionLabelUI() {
        weatherDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        weatherDescriptionLabel.textAlignment = .left
        weatherDescriptionLabel.text = "Description"
        weatherMainLabel.numberOfLines = 0
    }
    
    private func setupWeatherViewModelDelegate() {
        weatherViewModel.delegate = self
    }
    
}
//MARK: - Extensions
extension WeatherViewController: WeatherViewModelDelegate {
    func weatherInfoFetched(response: WeatherResponse) {
        DispatchQueue.main.async {
            self.countryLabel.text = "Country: \(response.city.country)"
            self.cityLabel.text = "City: \(response.city.name)"
            self.weatherMainLabel.text = "Weather: \(response.list[0].weather[0].main)"
            self.weatherDescriptionLabel.text = "Weather Description: \(response.list[0].weather[0].description)"
        }
    }
}
