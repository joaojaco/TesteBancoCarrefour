//
//  UsersListService.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import Foundation

protocol UsersListServiceProtocol {
    typealias UsersListResult = Result<[User],CustomError>
    func fetchUsers(completion: @escaping (UsersListResult) -> Void)
}

struct UsersListServiceDefault: UsersListServiceProtocol {
    
    private var networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcherDefault()
    
    init(networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcherDefault()) {
        self.networkDispatcher = networkDispatcher
    }
    
    func fetchUsers(completion: @escaping (UsersListResult) -> Void) {
        networkDispatcher.request(path: Endpoints.Path.users, type: [User].self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(userlist):
                    completion(.success(userlist))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}
