//
//  CityViewController.swift
//  EcoTrackerApp
//
//  Created by Eka Kelenjeridze on 30.11.23.
//

import UIKit
import GenericNetworkLayer

final class CityViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var cities = [City]()
    private let viewModel = CityViewModel(networkManager: Network())
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupTableView()
        
        setupViewModelDelegate()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CityUITableViewCell.self, forCellReuseIdentifier: CityUITableViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
}

// MARK: - TableVIew DataSource Methods
extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityUITableViewCell.identifier, for: indexPath)
                as? CityUITableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: cities[indexPath.row])
        return cell
    }
}

// MARK: - TableVIew Delegate Methods
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCity(at: indexPath)
    }
}

// MARK: - CityViewModel Delegate Methods
extension CityViewController: CityViewModelDelegate {
    func citiesFetched(_ cities: [City]) {
        self.cities = cities
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func navigateToSpecieDetails(with cityID: Int) {
        //        let speciesPage = SpecieViewController(cityID: cityID)
        //        navigationController?.pushViewController(speciesPage, animated: true)
    }
    
    func showError(_ error: Error) {
        print(error.localizedDescription)
    }
}
