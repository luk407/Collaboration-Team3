//
//  SpeciesViewController.swift
//  EcoTrackerApp
//
//  Created by Luka Gazdeliani on 29.11.23.
//  Modified by Eka Kelenjeridze on 30.11.23.
//

import UIKit
import GenericNetworkLayer

final class SpeciesViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 150
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var species = [Specie]()
    private var viewModel: SpeciesViewModel
    
    // MARK: - Init
    init(cityID: Int) {
        viewModel = SpeciesViewModel(cityID: cityID, networkManager: NetworkManager())
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupNavigationBar()
        setupTableView()
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Observed Species"
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        
        tableView.register(SpeciesUITableViewCell.self, forCellReuseIdentifier: SpeciesUITableViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableVIew DataSource Methods
extension SpeciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        species.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpeciesUITableViewCell.identifier, for: indexPath)
                as? SpeciesUITableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: species[indexPath.row])
        return cell
    }
}

// MARK: - SpecieViewModel Delegate Methods
extension SpeciesViewController: SpeciesViewModelDelegate {
    func speciesFetched(_ species: [Specie]) {
        self.species = species
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print(error.localizedDescription)
    }
}
