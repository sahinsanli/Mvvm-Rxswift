//
//  File.swift
//  rxSwiftMVVM
//
//  Created by Şahin Şanlı on 8.09.2025.
//

import Foundation

enum CryptoError: Error {
    case invalidData
    case parsingError
}


class Service {
    
    func downloadCurrecncies(url: URL,completion: @escaping (Result<[Crypto],CryptoError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, URLResponse, error in
            
            if let error = error{
                completion(.failure(.invalidData))
            }
            else if let data = data{
                let cryptolist = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptolist = cryptolist{
                    completion(.success(cryptolist))
                }
                else{
                    completion(.failure(.parsingError))
                }
            }
            
        }.resume()
        
    }
    
    
}
