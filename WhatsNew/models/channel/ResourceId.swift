//
//  ResourceId.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import Foundation

struct ResourceId: Codable, CustomDebugStringConvertible {
    let channelId: String
    
    var debugDescription: String {
        return "ResourceId{channelId:\(channelId)}"
    }
}
