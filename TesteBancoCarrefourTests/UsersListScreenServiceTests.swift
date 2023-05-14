//
//  TesteBancoCarrefourTests.swift
//  TesteBancoCarrefourTests
//
//  Created by João Jacó on 11/05/23.
//

import XCTest
@testable import TesteBancoCarrefour

final class UsersListScreenServiceTests: XCTestCase {

    func testFetchUsers_Success() {
        //given
        let mockNetworkDispatcher = MockNetworkDispatcher()
        let service = UsersListServiceDefault(networkDispatcher: mockNetworkDispatcher)
        let userList = [User(login: "login", id: 1, avatarUrl: "avatarUrl")]
        
        //when
        mockNetworkDispatcher.result = .success(userList)
        service.fetchUsers { result in
            switch result {
            case .success(let userList):
                XCTAssert(!userList.isEmpty)
            case .failure:
                XCTFail("Should be success")
            }
        }
        
        //then
        XCTAssertEqual(mockNetworkDispatcher.givenPath, Endpoints.Path.users)
        XCTAssertTrue(mockNetworkDispatcher.didCallRequest)
    }
    
    func testFetchUsers_Failure() {
        //given
        let mockNetworkDispatcher = MockNetworkDispatcher()
        let service = UsersListServiceDefault(networkDispatcher: mockNetworkDispatcher)
        
        //when
        mockNetworkDispatcher.result = .failure(CustomError.parseError)
        
        service.fetchUsers { result in
            switch result {
            case .success:
                XCTFail("Should be fail")
            case .failure(let error):
                XCTAssertTrue(error == .parseError)
            }
        }
        
        //then
        XCTAssertEqual(mockNetworkDispatcher.givenPath, Endpoints.Path.users)
        XCTAssertTrue(mockNetworkDispatcher.didCallRequest)
    }

}
