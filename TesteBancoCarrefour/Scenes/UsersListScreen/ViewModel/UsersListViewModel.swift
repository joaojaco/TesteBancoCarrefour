//
//  UsersListScreenViewModel.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 12/05/23.
//

import Foundation
import UIKit

protocol UsersListScreenViewModelDelegate: AnyObject {
    func didFetchUsers()
    func didFailToFetchUsers(_ error: String)
}

protocol UsersListViewModelProtocol {
    var usersListDelegate: UsersListScreenViewModelDelegate? { get set }
    func fetchUsers()
    func filterUsers(query: String)
    func getUsersLogin(index: Int) -> String
    func getUsersAvatarUrl(index: Int) -> String
    func getUsersCount() -> Int
}

class UsersListViewModel: UsersListViewModelProtocol {
    
    // MARK: Properties
    
    private var query: String?
    private(set) var usersList: [User]?
    private var filteredUsersList: [User]? {
        usersList?.filter { user in
            guard let query = self.query, !query.isEmpty else { return true }
            return user.login.lowercased().contains(query.lowercased())
        }
    }
    
    // MARK: Dependencies
    
    weak var usersListDelegate: UsersListScreenViewModelDelegate?
    private var service: UsersListServiceProtocol
    
    // MARK: Init
    
    init(service: UsersListServiceProtocol = UsersListServiceDefault()) {
        self.service = service
    }
    
    func fetchUsers() {
        service.fetchUsers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.usersList = users
                self.usersListDelegate?.didFetchUsers()
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.usersListDelegate?.didFailToFetchUsers(error.localizedDescription)
            }
        }
    }
    
    func getUsersLogin(index: Int) -> String {
        guard let usersName = filteredUsersList?[index].login else { return "" }
        return usersName
    }
    
    func getUsersAvatarUrl(index: Int) -> String {
        guard let usersAvatarUrl = filteredUsersList?[index].avatarUrl else { return "" }
        return usersAvatarUrl
    }
    
    func getUsersCount() -> Int {
        return filteredUsersList?.count ?? 0
    }
    
    func filterUsers(query: String) {
        self.query = query
    }
    
}
