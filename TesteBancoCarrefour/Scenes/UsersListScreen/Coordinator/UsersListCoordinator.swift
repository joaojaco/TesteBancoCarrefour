//
//  UsersListCoordinator.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 12/05/23.
//

import UIKit

class UsersListCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UsersListFactory.buildUsersListScreen()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func didSelectUser(login: String) {
        parentCoordinator?.goToUsersDetailsScreen(login: login)
    }
    
    
}
