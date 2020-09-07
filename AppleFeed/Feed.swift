//
//  Feed.swift
//  AppleFeed
//
//  Created by Rave BizzDev on 9/6/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import Foundation

struct Feed: Decodable {
    let feed: AlbumFeed
}

struct AlbumFeed: Decodable {
    let results: [Album]
}

struct Album: Decodable, Hashable {
    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.name == rhs.name
    }
    
    let artistName: String
    let name: String
    let artworkUrl100: String
    let releaseDate: String
}
