//
//  UsersDetailsTableViewHeaderView.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 13/05/23.
//

import UIKit

class UsersDetailsTableViewHeaderView: UIView {
    
    var viewModel: UsersDetailsViewModelProtocol?
    
    init(frame: CGRect = .zero, viewModel: UsersDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEWS
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var upperStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 16
        return stack
    }()
    
    private lazy var dataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var followsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var publicReposLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    func setupUI() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.getUserName()
        viewModel.getUserCompany().isEmpty ? (companyLabel.isHidden = true) : (companyLabel.text = "Trabalhou em \(viewModel.getUserCompany())")
        viewModel.getUserLocation().isEmpty ? (locationLabel.isHidden = true) : (locationLabel.text = "Mora em \(viewModel.getUserLocation())")
        viewModel.getUserPublicReposCount() == 0 ? (publicReposLabel.isHidden = true) : (publicReposLabel.text = "\(viewModel.getUserPublicReposCount()) repositórios públicos")
        viewModel.getUserFollowersCount() == 0 ? (followersLabel.isHidden = true) : (followersLabel.text = "\(viewModel.getUserFollowersCount()) seguidores")
        viewModel.getUserFollowingCount() == 0 ? (followingLabel.isHidden = true) : (followingLabel.text = "Seguindo \(viewModel.getUserFollowingCount())")

        if let avatarUrl = viewModel.getUserAvatarUrl() {
            guard let url = URL(string: avatarUrl) else { return }
            avatarImageView.load(url: url)
        }
    }
    
}

extension UsersDetailsTableViewHeaderView: ViewCode {
    func buildViewHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(upperStackView)
        mainStackView.addArrangedSubview(followsStackView)
        upperStackView.addArrangedSubview(avatarImageView)
        upperStackView.addArrangedSubview(dataStackView)
        dataStackView.addArrangedSubview(nameLabel)
        dataStackView.addArrangedSubview(companyLabel)
        dataStackView.addArrangedSubview(locationLabel)
        dataStackView.addArrangedSubview(publicReposLabel)
        followsStackView.addArrangedSubview(followersLabel)
        followsStackView.addArrangedSubview(followingLabel)
    }
    
    func setupConstraints() {
        mainStackView.anchor(top: topAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                            heightConstant: 230)
        dataStackView.anchor(heightConstant: 150)
        avatarImageView.anchor(widthConstant: 150, heightConstant: 150)
        followsStackView.anchor(heightConstant: 50)
        
    }
    
    func additionalConfigurations() {
        setupUI()
        backgroundColor = .white
        avatarImageView.layer.cornerRadius = 75
        avatarImageView.clipsToBounds = true
    }
    
}
