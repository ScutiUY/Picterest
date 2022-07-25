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
    
}

enum ImageEndPoint: ImageEndPointType {
    
    case getImage
    
    var baseUrl: String {
        switch self {
        case .getImage:
            return "https://api.unsplash.com/photos/random"
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
    
}
