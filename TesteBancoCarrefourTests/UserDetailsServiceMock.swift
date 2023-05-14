//
//  UserDetailsServiceMock.swift
//  TesteBancoCarrefourTests
//
//  Created by João Jacó on 13/05/23.
//

@testable import TesteBancoCarrefour

final class UserDetailsServiceMock: UsersDetailsServiceProtocol {
    
    private(set) var didCallFetchUserDetails = false
    private(set) var didCallFetchUsersRepos = false
    
    var fetchUserDetailsResult: UsersDetailsResult?
    var fetchUsersReposResult: UsersReposResult?
    var givenLogin: String?
    
    func fetchUsersDetails(login: String, completion: @escaping (UsersDetailsResult) -> Void) {
        didCallFetchUserDetails = true
        givenLogin = login
        completion(fetchUserDetailsResult!)
    }
    
    func fetchUsersRepos(login: String, completion: @escaping (UsersReposResult) -> Void) {
        didCallFetchUsersRepos = true
        givenLogin = login
        completion(fetchUsersReposResult!)
    }
}
