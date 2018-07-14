//
//  GetVideoResponse.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct GetVideoResponse: Codable, CustomDebugStringConvertible {
    
    let items: [VideoItem]
    
    var debugDescription: String {
        return "GetVideoResponse{\(items)}"
    }
}

