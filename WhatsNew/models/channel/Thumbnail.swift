//
//  Thumbnail.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Thumbnail: Codable, CustomDebugStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case medium
        case small = "default"
    }
    
    let medium: ThumbnailUrl
    let small: ThumbnailUrl
    
    var debugDescription: String {
        return "Item{medium:\(medium)}"
    }
}

struct ThumbnailUrl: Codable, CustomDebugStringConvertible {
    let url: String
    
    var debugDescription: String {
        return "ThumbnailUrl{url: \(url)}"
    }
}
