//
//  UsersDetailsView.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 13/05/23.
//

import UIKit

class UsersDetailsView: UIView {
    
    var viewModel: UsersDetailsViewModelProtocol?
    
    init(frame: CGRect = .zero, viewModel: UsersDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.viewModel?.usersDetailsDelegate = self
        setupView()
        indicatorView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        guard let viewModel = viewModel else { return UITableView()}
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UsersReposTableViewCell.self, forCellReuseIdentifier: UsersReposTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Private methods
    
}

extension UsersDetailsView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(indicatorView)
    }
    
    func setupConstraints() {
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        indicatorView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
    }
                                
}

extension UsersDetailsView: UsersDetailsViewModelDelegate {
    func didFailToFetchUsersDetails(_ error: String) {
        
    }
    
    func didFailToFetchUsersRepos(_ error: String) {
        
    }
    
    func didFetchData() {
        self.indicatorView.stopAnimating()
        tableView.reloadData()
    }
    
}

extension UsersDetailsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getUserRepoCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersReposTableViewCell.reuseIdentifier, for: indexPath) as? UsersReposTableViewCell else { return UITableViewCell() }
        
        guard let repoName = viewModel?.getRepoName(index: indexPath.row),
              let repoDescription = viewModel?.getRepoDescription(index: indexPath.row),
              let repoUrl = viewModel?.getRepoUrl(index: indexPath.row) else {
            return cell
            
        }
        
        cell.setupCell(repoName: repoName, repoDescription: repoDescription, repoUrl: repoUrl)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil}
        let customHeaderView = UsersDetailsTableViewHeaderView(viewModel: viewModel)
        return customHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
    
    
}
