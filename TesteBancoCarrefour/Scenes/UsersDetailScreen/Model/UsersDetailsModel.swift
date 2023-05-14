//
//  UsersDetailsModel.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 12/05/23.
//

import Foundation

struct UserDetails: Codable, Equatable {
    let login: String?
    let avatarUrl: String?
    let name: String?
    let company: String?
    let location: String?
    let publicRepos: Int?
    let followers: Int?
    let following: Int?

    init(
        login: String?,
        avatarUrl: String?,
        name: String?,
        company: String?,
        location: String?,
        publicRepos: Int?,
        followers: Int?,
        following: Int?
    ) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.company = company
        self.location = location
        self.publicRepos = publicRepos
        self.followers = followers
        self.following = following
    }

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case name, company, location
        case publicRepos = "public_repos"
        case followers, following
    }

//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let login: String? = try container.decode(String?.self, forKey: .login)
//        let avatarUrl: String? = try container.decode(String?.self, forKey: .avatarUrl)
//        let name: String? = try container.decode(String?.self, forKey: .name)
//        let company: String? = try container.decode(String?.self, forKey: .company)
//        let location: String? = try container.decode(String?.self, forKey: .location)
//        let publicRepos: Int? = try container.decode(Int?.self, forKey: .publicRepos)
//        let followers: Int? = try container.decode(Int?.self, forKey: .followers)
//        let following: Int? = try container.decode(Int?.self, forKey: .following)
//        self.init(login: login, avatarUrl: avatarUrl, name: name, company: company, location: location, publicRepos: publicRepos, followers: followers, following: following)
//    }
}

struct UserRepo: Codable {
    let name: String?
    let description: String?
    let url: String?
    
    init(name: String = "", description: String = "", url: String = "") {
        self.name = name
        self.description = description
        self.url = url
    }
}







