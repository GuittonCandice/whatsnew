//
//  ChannelActivityItem.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//


struct ChannelActivityItem: Codable, CustomDebugStringConvertible {
    let snippet: ChannelActivity
    let contentDetails: ContentDetail
    
    var debugDescription: String {
        return "ChannelactivityItem{snippet:\(snippet), contentDetails:\(contentDetails)}"
    }
}
