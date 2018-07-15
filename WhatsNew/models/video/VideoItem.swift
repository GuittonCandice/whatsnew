//
//  VideoItem.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct VideoItem: Codable, CustomDebugStringConvertible {
    
    let snippet: Video
    let statistics: Statistics
    
    var debugDescription: String {
        return "VideoItem{snippet:\(snippet), statistics:\(statistics)}"
    }
}
