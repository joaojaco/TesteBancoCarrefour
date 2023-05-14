//
//  MockNetworkDispatcher.swift
//  TesteBancoCarrefourTests
//
//  Created by João Jacó on 13/05/23.
//

import Foundation
@testable import TesteBancoCarrefour

final class MockNetworkDispatcher: NetworkDispatcherProtocol {
    
    var didCallRequest = false
    var result: Result<Any, CustomError>?
    var givenPath: String?
    
    func request<T>(path: String, type: T.Type, completion: @escaping (Result<T, TesteBancoCarrefour.CustomError>) -> Void) where T : Decodable {
        didCallRequest = true
        givenPath = path
        switch result {
        case .success(let object):
            completion(.success(object as! T))
        case .failure(let error):
            completion(.failure(error))
        case .none:
            break
        }
    }
    
}
