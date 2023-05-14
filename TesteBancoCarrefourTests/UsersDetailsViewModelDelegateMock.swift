//
//  UsersDetailsViewModelDelegateMock.swift
//  TesteBancoCarrefourTests
//
//  Created by João Jacó on 13/05/23.
//

@testable import TesteBancoCarrefour

final class UsersDetailsViewModelDelegateMock: UsersDetailsViewModelDelegate {
    
    private(set) var didCallDidFetchData = false
    private(set) var didCallDidFailToFetchUsersDetails = false
    private(set) var didCallDidFailToFetchUsersRepos = false
    
    func didFailToFetchUsersDetails(_ error: String) {
        didCallDidFailToFetchUsersDetails = true
    }
    
    func didFailToFetchUsersRepos(_ error: String) {
        didCallDidFailToFetchUsersRepos = true
    }
    
    func didFetchData() {
        didCallDidFetchData = true
    }
    
}
