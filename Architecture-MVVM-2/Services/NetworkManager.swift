//
//  NetworkManager.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 20.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPhotos(completion: @escaping (Result<[Photo]?, Error>) -> Void)
    func getData(from stringURL: String) -> Data
}

final class NetworkManager: NetworkServiceProtocol {
    static var shared = NetworkManager()
    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let stringURL = "https://jsonplaceholder.typicode.com/photos"
    
    func getPhotos(completion: @escaping (Result<[Photo]?, Error>) -> Void) {
        guard let url = URL(string: stringURL) else { return }
        
        let dataTask = session.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(photos))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
                return
            }
        }
        
        dataTask.resume()
    }
    
    func getData(from stringURL: String) -> Data {
        guard let url = URL(string: stringURL), let data = try? Data(contentsOf: url) else { return Data()}
        
        return data
    }
}
