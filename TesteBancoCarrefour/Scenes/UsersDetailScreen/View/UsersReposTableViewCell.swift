//
//  UsersReposTableViewCell.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 13/05/23.
//

import UIKit

class UsersReposTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    static let reuseIdentifier = "UsersReposTableViewCell"
    
    private var repoURL: String?
    
    // MARK: - INIT
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // MARK: - VIEWS
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var repoNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var repoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()

    private lazy var openRepoButton: UIButton = {
        let label = UIButton()
        label.setTitle("Open", for: .normal)
        return label
    }()

    // MARK: - PUBLIC METHODS
    
    func setupCell(repoName: String, repoDescription: String, repoUrl: String) {
        repoNameLabel.text = repoName
        repoDescriptionLabel.text = repoDescription
        self.repoURL = repoUrl
    }
    
    @objc
    private func openRepo() {
        UIApplication.shared.open(URL(string: repoURL!)!)
    }
}

extension UsersReposTableViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(repoNameLabel)
        stackView.addArrangedSubview(repoDescriptionLabel)
        stackView.addArrangedSubview(openRepoButton)
    }
    
    func setupConstraints() {
        let margin: CGFloat = 12
        stackView.anchorTo(superview: contentView, margin: margin)
        openRepoButton.anchor(heightConstant: 30)
    }
    
    func additionalConfigurations() {
        openRepoButton.addTarget(self, action: #selector(openRepo), for: .touchUpInside)
        openRepoButton.isEnabled = true
        openRepoButton.backgroundColor = .blue
        openRepoButton.layer.cornerRadius = 15
    }
    
}
