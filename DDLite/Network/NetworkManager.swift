//
//  APIExecutable.swift
//  DDLite
//
//  Created by Jason wang on 6/21/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case codableErrr
    case errWith(msg: String)
    case invalidData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .codableErrr:
            return "Unable to decode object"
        case .errWith(let msg):
            return "Error msg: \(msg)"
        case .invalidData:
            return "Invalid Data"
        }
    }
}

// TODO: need to refactor
class DDNetworkManager {
    static let shared = DDNetworkManager()
    
    let session = URLSession.shared
    
    func fetchDDMerchant(url: String, completionBlock: @escaping (Result<[Merchant], NetworkError>) -> Void ){
        fetchDataFrom(url: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let merchants = try JSONDecoder().decode([Merchant].self, from: data)
                    completionBlock(.success(merchants))
                } catch {
                    completionBlock(.failure(.codableErrr))
                }
            case .failure(let err):
                completionBlock(.failure(err))
            }
            
            
            
        }
        
    }
    
    func fetchDataFrom(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.errWith(msg: "invalid URL")))
            return
        }
        session.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
}
