//
//  Endpoints.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import Foundation

struct Endpoints {
    static let baseUrl = "https://api.github.com"
    struct Path {
        static let users = "/users"
        static func userRepos(for username: String) -> String {
            return "/users/\(username)/repos"
        }
        static func userDetails(for username: String) -> String {
            return "\(users)/\(username)"
        }
    }
}


