//
//  API.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFail(Error)
    case invalidResponse
    case failedResponse(statusCode: Int)
    case emptyData
    case decodeError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFail:
            return "HTTP 요청에 실패했습니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .failedResponse(let statusCode):
            return "(\(statusCode)) 실패한 상태코드"
        case .emptyData:
            return "데이터가 없습니다."
        case .decodeError:
            return "디코딩 실패"
        }
    }
}

class HttpClient {
    
    private let baseUrl = "https://api.unsplash.com/photos"
    
    func getImageData(path: String, params: [String: Any], completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        let queryParams = params.map { k, v in "\(k)=\(v)" }.joined(separator: "&")

        var fullPath = path.hasPrefix("http") ? path : self.baseUrl + path
        if !queryParams.isEmpty {
            fullPath += "?" + queryParams
        }
        guard let url = URL(string: fullPath) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .ephemeral)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFail(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.failedResponse(statusCode: httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            completion(.success(data))
            
        }
        task.resume()
    }
    
    
}
