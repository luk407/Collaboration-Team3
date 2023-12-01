//
//  SpecieUITableViewCell.swift
//  EcoTrackerApp
//
//  Created by Eka Kelenjeridze on 30.11.23.
//

import UIKit

final class CityUITableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "CitiesTableViewCell"
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
        setupCityNameLabel()
        prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CleanUp Content & PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = nil
    }
    
    //MARK: - Configure
    func configure(with city: City) {
        cityNameLabel.text = city.name
    }
    
    // MARK: - Private Methods
    private func setupView() {
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1
    }
    
    private func setupCityNameLabel() {
        addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}


