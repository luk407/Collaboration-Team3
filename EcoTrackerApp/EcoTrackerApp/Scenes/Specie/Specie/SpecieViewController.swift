////
////  SpecieViewController.swift
////  EcoTrackerApp
////
////  Created by Luka Gazdeliani on 29.11.23.
////  Modified by Eka Kelenjeridze on 30.11.23.
////
//
//import UIKit
//import GenericNetworkLayer
//
//final class SpecieViewController: UIViewController {
//    
//    // MARK: - Properties
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.rowHeight = UITableView.automaticDimension
////        tableView.backgroundColor = .systemBackground
//        tableView.backgroundColor = .orange
//        tableView.separatorStyle = .none
//        return tableView
//    }()
//    
////    private var viewModel = SpecieViewModel
////    private var species: SpecieDetails
//    
//    
//    // MARK: - Init
//    init(cityID: Int) {
////        viewModel = SpecieViewModel(cityID: cityID, networkManager: Network())
////        super.init(nibName: nil, bundle: nil)
////
////        viewModel.delegate = self
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - ViewLifeCycle
//       override func viewDidLoad() {
//           super.viewDidLoad()
//   
//           setupBackground()
//           setupTableView()
//       }
//    
//    // MARK: - Private Methods
//       private func setupBackground() {
//           view.backgroundColor = .systemBackground
//       }
//    
//    private func setupTableView() {
//        view.addSubview(tableView)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(SpecieUITableViewCell.self, forCellReuseIdentifier: SpecieUITableViewCell.identifier)
//        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//   
//}
//
//// MARK: - TableVIew DataSource Methods
//extension SpecieViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////         species.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell: UITableViewCell
////        let song = songs[indexPath.row]
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpecieUITableViewCell.identifier, for: indexPath)
//         as? SpecieUITableViewCell else {
//             return UITableViewCell()
//        }
////        cell.configure(with: species[indexPath.row])
//        return cell
//    }
//}
//
//// MARK: - TableVIew Delegate Methods
//extension SpecieViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let itemDetailsViewController = ItemDetailsViewController()
////        itemDetailsViewController.song = songs[indexPath.row]
////        navigationController?.pushViewController(itemDetailsViewController, animated: true)
//    }
//}
//
//// MARK: - SpecieViewModel Delegate Methods
//extension SpecieViewController: SpecieViewModelDelegate {
//    func cityIDFetched(_ cityID: Int) {
//        <#code#>
//    }
//    
//    func speciesFetched(_ species: [SpecieDetails]) {
//        <#code#>
//    }
//    
//    func showError(_ error: Error) {
//        print(error.localizedDescription)
//    }
//    
//    
//}
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
////    private let mainStackView: UIStackView = {
////        let stackView = UIStackView()
////        stackView.axis = .vertical
////        stackView.distribution = .equalCentering
////        stackView.translatesAutoresizingMaskIntoConstraints = false
////        return stackView
////    }()
////
////    private let specieImageView: UIImageView = {
////        let imageView = UIImageView()
////        imageView.contentMode = .scaleAspectFill
////        imageView.clipsToBounds = true
////        //        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
////        return imageView
////    }()
////
////    // MARK: - ViewLifeCycle
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        setupBackground()
////    }
////
////    // MARK: - Private Methods
////    private func setupBackground() {
////        view.backgroundColor = .systemBackground
////    }
////
////    private func setupMainStackView() {
////        view.addSubview(mainStackView)
////        mainStackView.addArrangedSubview(specieImageView)
////
////        NSLayoutConstraint.activate([
////            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
////            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
////            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
////        ])
////    }
////
////    private func createInfoStackView(_ title: String, detail: String) {
////        let stackView = UIStackView()
////        stackView.spacing = 20
////        stackView.alignment = .leading
////        stackView.isLayoutMarginsRelativeArrangement = true
////        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
////
////        let titleLabel = UILabel()
////        titleLabel.text = title
////        titleLabel.textColor = .darkGray
////        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
////        titleLabel.widthAnchor.constraint(equalToConstant: 86).isActive = true
////
////        let detailLabel = UILabel()
////        detailLabel.text = detail
////        detailLabel.textColor = .darkGray
////        detailLabel.numberOfLines = 0
////        detailLabel.font = .systemFont(ofSize: 14, weight: .light)
////
////        stackView.addArrangedSubview(titleLabel)
////        stackView.addArrangedSubview(detailLabel)
////
////        mainStackView.addArrangedSubview(stackView)
////    }
////
////}
////
//
