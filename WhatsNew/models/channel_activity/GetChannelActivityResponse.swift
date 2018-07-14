//
//  GetChannelActivityResponse.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import Foundation

struct GetChannelActivityResponse: Codable, CustomDebugStringConvertible {
    let items: [ChannelActivityItem]
    
    
    var debugDescription: String {
        return "GetChannelActivityResponse{\(items)}"
    }
}
