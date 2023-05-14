//
//  Network.swift
//  TesteBancoCarrefour
//
//  Created by João Jacó on 11/05/23.
//

import Foundation

protocol NetworkDispatcherProtocol {
    func request<T: Decodable>(path: String, type: T.Type, completion: @escaping (Result<T, CustomError>) -> Void)
}

class NetworkDispatcherDefault: NetworkDispatcherProtocol {
    
    private let session = URLSession.shared
    
    func request<T: Decodable>(path: String, type: T.Type, completion: @escaping (Result<T, CustomError>) -> Void) {
        guard var components = URLComponents(string: Endpoints.baseUrl) else { return }
        components.path = path
        
        guard let url = components.url else {
            completion(.failure(.badUrl))
            return
        }

        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(CustomError.networkError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            do {
                let parsedData = try JSONDecoder().decode(type, from: data)
                completion(.success(parsedData))
            } catch {
                completion(.failure(CustomError.parseError))
            }
        }.resume()
    }
    
    
    
}



