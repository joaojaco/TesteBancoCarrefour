//
//  AppDelegate.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
//        window.rootViewController = UsersListFactory.buildUsersListScreen()
//        window.makeKeyAndVisible()
        return true
    }


}

