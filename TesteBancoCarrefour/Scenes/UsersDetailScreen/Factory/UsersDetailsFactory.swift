//
//  UsersDetailsFactory.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 13/05/23.
//

import UIKit

struct UsersDetailsFactory {
    static func buildUsersDetailsScreen(login: String) -> UsersDetailsViewController {
        let viewModel = UsersDetailsViewModel(login: login)
        let viewController = UsersDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
