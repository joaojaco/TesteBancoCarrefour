//
//  UsersDetailsCoordinator.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 13/05/23.
//

import UIKit

class UsersDetailsCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func start(login: String) {
        let vc = UsersDetailsFactory.buildUsersDetailsScreen(login: login)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
