//
//  UsersListFactory.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 12/05/23.
//

import UIKit

struct UsersListFactory {
    static func buildUsersListScreen() -> UsersListViewController {
        let viewModel = UsersListViewModel()
        let viewController = UsersListViewController(viewModel: viewModel)
        return viewController
    }
}
