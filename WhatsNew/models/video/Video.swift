//
//  VideoSnippet.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Video: Codable, CustomDebugStringConvertible {
    
    let title: String
    let description: String
    let thumbnails: Thumbnail
    
    var debugDescription: String {
        return "Video{title:\(title), description: \(description)}"
    }
}
