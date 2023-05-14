//
//  UsersDetailsViewController.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 13/05/23.
//

import UIKit

class UsersDetailsViewController: UIViewController {
    
    weak var coordinator: UsersDetailsCoordinator?
    private let viewModel: UsersDetailsViewModelProtocol
    private let usersDetailsView: UsersDetailsView
    
    init(viewModel: UsersDetailsViewModelProtocol) {
        self.viewModel = viewModel
        self.usersDetailsView = UsersDetailsView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = usersDetailsView
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchUsersDetails()
    }
        
    // MARK: - Functions
        
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Detalhes"
    }
    
}
    

