//
//  SpeciesUITableViewCell.swift
//  EcoTrackerApp
//
//  Created by Eka Kelenjeridze on 30.11.23.
//

import UIKit
import GenericNetworkLayer

final class SpeciesUITableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "SpeciesTableViewCell"
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        stackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let specieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"")
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private lazy var detailsWrapperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameInfoStackView, authorInfoStackView, wikipediaInfoStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return stackView
    }()
    
    private lazy var nameInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameInfoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorLabel, authorInfoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return stackView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wikipediaInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wikipediaURLLabel, wikipediaURLInfoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return stackView
    }()
    
    private let wikipediaURLLabel: UILabel = {
        let label = UILabel()
        label.text = "Wikipedia:"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wikipediaURLInfoLabel: UILabel = {
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
        prepareForReuse()
        setupView()
        setupMainStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CleanUp Content & PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        specieImageView.image = nil
        nameInfoLabel.text = nil
        authorInfoLabel.text = nil
        wikipediaURLInfoLabel.text = nil
    }
    
    //MARK: - Configure
    func configure(with specie: SpecieDetails) {
        setImage(from: specie.defaultPhoto.mediumURL)
        nameInfoLabel.text = specie.name
        authorInfoLabel.text = specie.defaultPhoto.attribution
        wikipediaURLInfoLabel.text = specie.wikipediaURL
    }
    
    // MARK: - Private Methods
    private func setupView() {
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1
    }
    
    private func setupMainStackView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(specieImageView)
        mainStackView.addArrangedSubview(detailsWrapperStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setImage(from url: String) {
        Network().downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.specieImageView.image = image
            }
        }
    }
}


