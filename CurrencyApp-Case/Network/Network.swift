//
//  Network.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 26.01.2023.
//

import Foundation
import UIKit


protocol CurrenciesWebServiceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: currenciesAPICall, completion: @escaping (Result<T, Error>) -> Void)
}
final class CurrenciesWebService: CurrenciesWebServiceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: currenciesAPICall, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = URLRequest(url: path.url)
        let task = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.dataNotFound))
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
enum NetworkError: Error {
    case dataNotFound
}
