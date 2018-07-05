//
//  GetChannelResponse.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct GetChannelResponse: Codable, CustomDebugStringConvertible {
    let items: [Item]
    
    var debugDescription: String {
        return "GetChannelResponse{\(items)}"
    }
}
