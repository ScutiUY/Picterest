//
//  ImageInfo.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/25.
//

import Foundation

struct ImageData: Decodable {
    var id: String
    var imageUrl: ImageUrl
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "urls"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        imageUrl = try container.decode(ImageUrl.self, forKey: .imageUrl)
    }
}

struct ImageUrl: Decodable {
    var rawUrl: String
    var regularUrl: String
    var smallUrl: String
    
    enum CodingKeys: String, CodingKey {
        case rawUrl = "raw"
        case regularUrl = "regular"
        case samllUrl = "small"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rawUrl = try container.decode(String.self, forKey: .rawUrl)
        regularUrl = try container.decode(String.self, forKey: .regularUrl)
        smallUrl = try container.decode(String.self, forKey: .samllUrl)
    }
    
}

class ImageInfo {
    var id = ""
    var memo = ""
    var originUrl = ""
    var localUrl = ""
}
