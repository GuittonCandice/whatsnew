//
//  Thumbnail.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Thumbnail: Codable, CustomDebugStringConvertible {
    let medium: ThumbnailUrl
    
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
