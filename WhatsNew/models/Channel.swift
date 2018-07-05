//
//  Channel.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit

struct Channel : Codable, CustomDebugStringConvertible {
    let title: String
    let description: String
    
    var debugDescription: String {
        return "Channel{title:\(title), description:\(description)}"
    }
}
