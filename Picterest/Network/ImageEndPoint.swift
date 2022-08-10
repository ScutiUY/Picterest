//
//  ImageEndPoint.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/25.
//

import Foundation

protocol ImageEndPointType {
    var baseUrl: String { get }
    var accessKey: String { get }
    var method: HttpMethod { get }
    var parameters: [String: Any] { get }
}

enum ImageEndPoint: ImageEndPointType {
    
    case getImage(page: Int)
    
    var baseUrl: String {
        switch self {
        case .getImage:
            return URLRepository.baseUrl
        }
    }
    
    var accessKey: String {
        switch self {
        case .getImage:
            return "r6IAzQw2BwX75Nx0Y9ACzqM1yc1MdVEvNavR2jnZ-Wc"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getImage:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getImage:
            return URLRepository.photo
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getImage(let page):
            return ["client_id": self.accessKey, "page": page, "per_page": 15]
        }
    }
    
    func asUrlRequest() -> URLRequest? {
        let queryParams = parameters.map { k, v in "\(k)=\(v)" }.joined(separator: "&")
        var fullPath = path.hasPrefix("http") ? path : baseUrl + path
        if !queryParams.isEmpty {
            fullPath += "?" + queryParams
        }
        guard let url = URL(string: fullPath) else { return nil }
        
        return URLRequest(url: url)
    }
}
