//
//  UsersDetailsViewModelTests.swift
//  TesteBancoCarrefourTests
//
//  Created by João Jacó on 13/05/23.
//

import XCTest
@testable import TesteBancoCarrefour

final class UserDetailsViewModelTests: XCTestCase {

    func testFetchUserDetails_Success() {
        //given
        let login = "jaco"
        let expectedUserDetails = UserDetails(login: "login", avatarUrl: "avatarURL", name: "name", company: "company", location: "location", publicRepos: 12, followers: 13, following: 14)
        let expectedUserRepos = [UserRepo(name: "name", description: "description", url: "url")]
        let mockService = UserDetailsServiceMock()
        let mockDelegate = UsersDetailsViewModelDelegateMock()
        let sut = UsersDetailsViewModel(service: mockService, login: login)
        
        //when
        mockService.fetchUserDetailsResult = .success(expectedUserDetails)
        mockService.fetchUsersReposResult = .success(expectedUserRepos)
        sut.usersDetailsDelegate = mockDelegate
        
        sut.fetchUsersDetails()
        
        //then
        XCTAssertTrue(mockService.didCallFetchUserDetails)
        XCTAssertTrue(mockService.didCallFetchUsersRepos)
        
        XCTAssertEqual(expectedUserDetails.publicRepos, sut.getUserPublicReposCount())
        XCTAssertEqual(expectedUserDetails.name, sut.getUserName())
        XCTAssertEqual(expectedUserDetails.company, sut.getUserCompany())
        XCTAssertEqual(expectedUserDetails.avatarUrl, sut.getUserAvatarUrl())
        XCTAssertEqual(expectedUserDetails.location, sut.getUserLocation())
        XCTAssertEqual(expectedUserDetails.followers, sut.getUserFollowersCount())
        XCTAssertEqual(expectedUserDetails.following, sut.getUserFollowingCount())
        XCTAssertEqual(expectedUserRepos.count, sut.getUserRepoCount())
        XCTAssertEqual(expectedUserRepos.first?.name, sut.getRepoName(index: 0))
        XCTAssertEqual(expectedUserRepos.first?.description, sut.getRepoDescription(index: 0))
        XCTAssertEqual(expectedUserRepos.first?.url, sut.getRepoUrl(index: 0))
    }
    
    func testFetchUserDetails_Failure() {
        //given
        let login = "jaco"
        let expectedUserDetails = UserDetails(login: "login", avatarUrl: "avatarURL", name: "name", company: "company", location: "location", publicRepos: 12, followers: 13, following: 14)
        let mockService = UserDetailsServiceMock()
        let mockDelegate = UsersDetailsViewModelDelegateMock()
        let sut = UsersDetailsViewModel(service: mockService, login: login)
        
        //when
        mockService.fetchUserDetailsResult = .success(expectedUserDetails)
        mockService.fetchUsersReposResult = .failure(CustomError.emptyData)
        sut.usersDetailsDelegate = mockDelegate
        
        sut.fetchUsersDetails()
        
        //then
        XCTAssertTrue(mockService.didCallFetchUserDetails)
        XCTAssertTrue(mockDelegate.didCallDidFailToFetchUsersRepos)
    }
    
    func testFetchUserRepos_Failure() {
        //given
        let login = "jaco"
        let expectedUserRepos = [UserRepo(name: "name", description: "description", url: "url")]
        let mockService = UserDetailsServiceMock()
        let mockDelegate = UsersDetailsViewModelDelegateMock()
        let sut = UsersDetailsViewModel(service: mockService, login: login)
        
        //when
        mockService.fetchUserDetailsResult = .failure(CustomError.emptyData)
        mockService.fetchUsersReposResult = .success(expectedUserRepos)
        sut.usersDetailsDelegate = mockDelegate
        
        sut.fetchUsersDetails()
        
        //then
        XCTAssertTrue(mockService.didCallFetchUserDetails)
        XCTAssertTrue(mockDelegate.didCallDidFailToFetchUsersDetails)
    }

}
