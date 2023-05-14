//
//  UsersListView.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import UIKit

protocol UsersListViewDelegate: AnyObject {
    func didSelectUser(login: String)
}

class UsersListView: UIView {
    
    var viewModel: UsersListViewModelProtocol?
    weak var delegate: UsersListViewDelegate?
    
    init(frame: CGRect = .zero, viewModel: UsersListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.viewModel?.usersListDelegate = self
        setupView()
        indicatorView.startAnimating()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.register(UsersListTableViewCell.self, forCellReuseIdentifier: UsersListTableViewCell.reuseIdentifier)
        return tableView
    }()
    
}

extension UsersListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getUsersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListTableViewCell.reuseIdentifier, for: indexPath) as? UsersListTableViewCell else {
                return UITableViewCell()
            }
            
        guard let usersName = viewModel?.getUsersLogin(index: indexPath.row),
              let usersAvatarUrl = viewModel?.getUsersAvatarUrl(index: indexPath.row) else {
            return cell
        }
        
        cell.setupCell(userLogin: usersName, userAvatar: usersAvatarUrl)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        delegate?.didSelectUser(login: viewModel.getUsersLogin(index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return searchBar
    }
        
}

extension UsersListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterUsers(query: searchText)
        tableView.reloadData()
    }
}

extension UsersListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(indicatorView)
    }
    
    func setupConstraints() {
        tableView.anchorTo(superview: self)
        indicatorView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
    }
    
}

extension UsersListView: UsersListScreenViewModelDelegate {
    func didFetchUsers() {
        indicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func didFailToFetchUsers(_ error: String) {
        
    }
    
    
}
