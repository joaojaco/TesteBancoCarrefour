//
//  UsersListTableViewCell.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import UIKit

class UsersListTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    static let reuseIdentifier = "UsersListTableViewCell"
    
    // MARK: - INIT
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // MARK: - VIEWS
    
    private lazy var userLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userAvatarImage: UIImageView = {
        let image = UIImageView(image: UIImage())
        return image
    }()
    
    // MARK: - PUBLIC METHODS
    
    func setupCell(userLogin: String, userAvatar: String) {
        guard let url = URL(string: userAvatar) else { return }
        
        userLoginLabel.text = userLogin
        userAvatarImage.load(url: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userLoginLabel.text = ""
        userAvatarImage.image = nil
    }
}

// MARK: - EXTENSIONS

extension UsersListTableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(userAvatarImage)
        addSubview(userLoginLabel)
    }
    
    func setupConstraints() {
        userAvatarImage.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               topConstant: 10,
                               leftConstant: 10,
                               bottomConstant: 10,
                               widthConstant: 100,
                               heightConstant: 100)
        
        
        userLoginLabel.anchor(top: userAvatarImage.topAnchor,
                              left: userAvatarImage.rightAnchor,
                              bottom: userAvatarImage.bottomAnchor,
                              right: rightAnchor,
                              leftConstant: 10)
    }
    
    func additionalConfigurations() {
        userAvatarImage.layer.cornerRadius = 50
        userAvatarImage.clipsToBounds = true
    }
    
}
