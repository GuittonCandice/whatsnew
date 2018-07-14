//
//  ContentDetail.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct ContentDetail: Codable, CustomDebugStringConvertible {
    let upload: Upload
    
    var debugDescription: String {
        return "ContentDetail{upload:\(upload)}"
    }
}

struct Upload: Codable {
    let videoId: String
    
    var debugDescription: String {
        return "Upload{videoId:\(videoId)}"
    }
}
