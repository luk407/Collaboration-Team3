//
//  TabBarController.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Properties
    private let airQualityViewController = AirQualityViewController()
    private let weatherViewController = WeatherViewController()
    private let specieViewController = CityViewController()
    private let solarResourceViewController = SolarResourceViewController()
    private let populationViewController = PopulationViewController()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Private Methods
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
    private func setupTabBar() {
        let airQualityNavigationController = self.createNav(
            with: "Air Quality",
            and: UIImage(systemName: "wind.circle.fill"),
            vc: airQualityViewController
        )
        
        let weatherNavigationController = self.createNav(
            with: "Weather",
            and: UIImage(systemName: "umbrella.fill"),
            vc: weatherViewController
        )
        
        let specieNavigationController = self.createNav(
            with: "Specie",
            and: UIImage(systemName: "bird.circle.fill"),
            vc: specieViewController
        )
        
        let solarResourceNavigationController = self.createNav(
            with: "Solar Resource",
            and: UIImage(systemName: "sun.max.circle.fill"),
            vc: solarResourceViewController
        )
        
        let populationNavigationController = self.createNav(
            with: "Population",
            and: UIImage(systemName: "person.3.fill"),
            vc: populationViewController
        )
        
        setViewControllers(
            [airQualityNavigationController,
             weatherNavigationController,
             specieNavigationController,
             solarResourceNavigationController,
             populationNavigationController],
            animated: true)
        
        tabBar.tintColor = UIColor(red: 0.93, green: 0.56, blue: 0.37, alpha: 1.00)
        tabBar.unselectedItemTintColor = .systemGray
    }

}
