//
//  CustomErrors.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import Foundation

enum CustomError: Error, Equatable {
    case parseError
    case networkError(String)
    case badUrl
    case emptyData
}
