//
//  AppCoordinator.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController?
    
    private var window: UIWindow
    
    init(window: UIWindow, navigationController: UINavigationController? = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        navigationController?.delegate = self
        goToUsersListScreen()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    func goToUsersListScreen() {
        let child = UsersListCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func goToUsersDetailsScreen(login: String) {
        let child = UsersDetailsCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start(login: login)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() where coordinator === child {
                childCoordinators.remove(at: index)
                break
        }
    }
    
}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        if let usersListViewController = fromViewController as? UsersListViewController {
            childDidFinish(usersListViewController.coordinator)
        }
    }
}
