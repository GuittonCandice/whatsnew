//
//  Favorite.swift
//  WhatsNew
//
//  Created by Candice Guitton on 15/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct VideoFavorite: Codable, CustomDebugStringConvertible, Equatable {
    
    let videoId: String
    var url: String?
    var smallUrl: String?
    var title: String?
    var description: String?
    
    var debugDescription: String {
        return "Favorite{videoId:\(videoId)}"
    }
    
    static func ==(lhs: VideoFavorite, rhs: VideoFavorite) -> Bool {
        return lhs.videoId == rhs.videoId
    }
}
