//
//  Users.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarUrl = "avatar_url"
    }
}
