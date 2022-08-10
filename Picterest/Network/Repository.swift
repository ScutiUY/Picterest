//
//  Repository.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/25.
//

import Foundation

final class Repository {
    
    private let httpClient = HttpClient()
    
    func fetchImageData(_ endPoint: ImageEndPoint, completion: @escaping (Result<[PictureData], NetworkError>) -> Void) {
        httpClient.getImageData(endpoint: endPoint) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([PictureData].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodeError))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
