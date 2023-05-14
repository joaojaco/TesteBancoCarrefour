//
//  ViewModel.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 12/05/23.
//

import Foundation

protocol UsersDetailsViewModelDelegate: AnyObject {
    func didFailToFetchUsersDetails(_ error: String)
    func didFailToFetchUsersRepos(_ error: String)
    func didFetchData()
}

protocol UsersDetailsViewModelProtocol {
    var usersDetailsDelegate: UsersDetailsViewModelDelegate? { get set }
    func fetchUsersDetails()
    func getUserLogin() -> String
    func getUserAvatarUrl() -> String?
    func getUserName() -> String
    func getUserCompany() -> String
    func getUserLocation() -> String
    func getUserPublicReposCount() -> Int
    func getUserFollowersCount() -> Int
    func getUserFollowingCount() -> Int
    func getUserRepo(index: Int) -> UserRepo
    func getUserRepoCount() -> Int
    func getRepoName(index: Int) -> String
    func getRepoDescription(index: Int) -> String
    func getRepoUrl(index: Int) -> String
    
}

class UsersDetailsViewModel: UsersDetailsViewModelProtocol {
    
    private(set) var userDetails: UserDetails?
    private(set) var userRepoList: [UserRepo]?
    private var login: String
    private var service: UsersDetailsServiceProtocol
    weak var usersDetailsDelegate: UsersDetailsViewModelDelegate?
    
    init(service: UsersDetailsServiceProtocol = UsersDetailsServiceDefault(), login: String) {
        self.service = service
        self.login = login
    }
    
    func fetchUsersDetails() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        service.fetchUsersDetails(login: login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                userDetails = details
                dispatchGroup.leave()
            case .failure(let error):
                usersDetailsDelegate?.didFailToFetchUsersDetails(error.localizedDescription)
            }
        }
        
        dispatchGroup.enter()
        self.service.fetchUsersRepos(login: self.login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repos):
                userRepoList = repos
                dispatchGroup.leave()
            case .failure(let error):
                usersDetailsDelegate?.didFailToFetchUsersRepos(error.localizedDescription)
            }
        }
        
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.usersDetailsDelegate?.didFetchData()
        }
    }
    
    func getUserLogin() -> String {
        return userDetails?.login ?? ""
    }

    func getUserAvatarUrl() -> String? {
        guard let avatarUrl = userDetails?.avatarUrl else { return nil }
        return avatarUrl
    }

    func getUserName() -> String {
        return userDetails?.name ?? ""
    }

    func getUserCompany() -> String {
        return userDetails?.company ?? ""
    }

    func getUserLocation() -> String {
        return userDetails?.location ?? ""
    }

    func getUserPublicReposCount() -> Int {
        return userDetails?.publicRepos ?? 0
    }

    func getUserFollowersCount() -> Int {
        return userDetails?.followers ?? 0
    }

    func getUserFollowingCount() -> Int {
        return userDetails?.following ?? 0
    }
    
    func getUserRepo(index: Int) -> UserRepo {
        guard let repo = userRepoList?[index] else { return UserRepo()}
        return repo
    }
    
    func getUserRepoCount() -> Int {
        return userRepoList?.count ?? 0
    }
    
    func getRepoName(index: Int) -> String {
        return userRepoList?[index].name ?? ""
    }
    
    func getRepoDescription(index: Int) -> String {
        return userRepoList?[index].description ?? ""
    }
    
    func getRepoUrl(index: Int) -> String {
        return userRepoList?[index].url ?? ""
    }
    
}
