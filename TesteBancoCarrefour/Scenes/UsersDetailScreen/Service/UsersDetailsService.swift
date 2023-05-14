//
//  UsersDetailsService.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 13/05/23.
//

import Foundation

protocol UsersDetailsServiceProtocol {
    typealias UsersDetailsResult = Result<UserDetails,CustomError>
    typealias UsersReposResult = Result<[UserRepo],CustomError>
    func fetchUsersDetails(login: String, completion: @escaping (UsersDetailsResult) -> Void)
    func fetchUsersRepos(login: String, completion: @escaping (UsersReposResult) -> Void)
}

struct UsersDetailsServiceDefault: UsersDetailsServiceProtocol {
    
    private let networkDispatcher: NetworkDispatcherProtocol
    
    init(networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcherDefault()) {
        self.networkDispatcher = networkDispatcher
    }
    
    func fetchUsersDetails(login: String, completion: @escaping (UsersDetailsResult) -> Void) {
        networkDispatcher.request(path: Endpoints.Path.userDetails(for: login), type: UserDetails.self) { result in
            self.handleUserResult(result, completion: completion)
        }
    }
    
    func fetchUsersRepos(login: String, completion: @escaping (UsersReposResult) -> Void) {
        networkDispatcher.request(path: Endpoints.Path.userRepos(for: login), type: [UserRepo].self) { result in
            self.handleUserReposResult(result, completion: completion)
        }
    }
    
    private func handleUserResult(_ result: UsersDetailsResult, completion: @escaping (UsersDetailsResult) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let userDetails):
                completion(.success(userDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleUserReposResult(_ result: UsersReposResult, completion: @escaping (UsersReposResult) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let userRepos):
                completion(.success(userRepos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    
}
