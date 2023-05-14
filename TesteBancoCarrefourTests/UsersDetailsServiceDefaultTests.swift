//
//  UsersDetailsServiceDefaultTests.swift
//  TesteBancoCarrefourTests
//
//  Created by João Jacó on 13/05/23.
//

import XCTest
@testable import TesteBancoCarrefour

final class UsersDetailsServiceTests: XCTestCase {

    func testFetchUserDetails_Success() {
        //given
        let mockNetworkDispatcher = MockNetworkDispatcher()
        let service = UsersDetailsServiceDefault(networkDispatcher: mockNetworkDispatcher)
        let login = "jaco"
        let expectedUserDetails = UserDetails(login: login, avatarUrl: nil, name: nil, company: nil, location: nil, publicRepos: nil, followers: nil, following: nil)
        
        //when
        mockNetworkDispatcher.result = .success(expectedUserDetails)
        service.fetchUsersDetails(login: login) { result in
            switch result {
            case .success(let userDetails):
                XCTAssertEqual(expectedUserDetails, userDetails)
            case .failure:
                XCTFail("Should be success")
            }
        }
        
        //then
        XCTAssertEqual(mockNetworkDispatcher.givenPath, Endpoints.Path.userDetails(for: login))
        XCTAssertTrue(mockNetworkDispatcher.didCallRequest)
    }
    
    func testFetchUserDetails_Failure() {
        //given
        let mockNetworkDispatcher = MockNetworkDispatcher()
        let service = UsersDetailsServiceDefault(networkDispatcher: mockNetworkDispatcher)
        let login = "jaco"
        
        //when
        mockNetworkDispatcher.result = .failure(CustomError.parseError)
        
        service.fetchUsersDetails(login: login) { result in
            switch result {
            case .success:
                XCTFail("Should be fail")
            case .failure(let error):
                XCTAssertTrue(error == .parseError)
            }
        }
        
        //then
        XCTAssertEqual(mockNetworkDispatcher.givenPath, Endpoints.Path.userDetails(for: login))
        XCTAssertTrue(mockNetworkDispatcher.didCallRequest)
    }

}
