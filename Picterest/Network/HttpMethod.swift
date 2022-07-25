//
//  HTTPClient.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/25.
//

import Foundation

enum HttpMethod: String{
    case get = "GET"
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
