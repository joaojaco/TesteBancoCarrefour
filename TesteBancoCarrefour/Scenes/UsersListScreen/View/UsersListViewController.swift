//
//  UsersListScreenViewController.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 12/05/23.
//

import UIKit

class UsersListViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: UsersListCoordinator?
    private let viewModel: UsersListViewModelProtocol
    private let usersListView: UsersListView
    
    init(viewModel: UsersListViewModelProtocol) {
        self.viewModel = viewModel
        self.usersListView = UsersListView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.usersListView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = usersListView
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchUsers()
    }
        
    // MARK: - Functions
        
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Usuários"
    }
    
}

extension UsersListViewController: UsersListViewDelegate {
    func didSelectUser(login: String) {
        coordinator?.didSelectUser(login: login)
    }
    
}
