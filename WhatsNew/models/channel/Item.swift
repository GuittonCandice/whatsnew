//
//  Item.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Item: Codable, CustomDebugStringConvertible {
    let snippet: Channel
    
    var debugDescription: String {
        return "Item{snippet:\(snippet)}"
    }
}
