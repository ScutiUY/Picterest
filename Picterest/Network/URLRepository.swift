//
//  URLRepository.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/28.
//

import Foundation

class URLRepository {
    static var baseUrl: String {
        get {
            return "https://api.unsplash.com"
        }
    }
    static var photo: String {
        get {
            return "/photos"
        }
    }
}
