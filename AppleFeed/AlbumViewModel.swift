//
//  AlbumViewModel.swift
//  AppleFeed
//
//  Created by Rave BizzDev on 9/6/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import Foundation


class AlbumViewModel {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    static let monthFirstDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-d-yyyy"
        return dateFormatter
    }()
    
    let imageURL: String
    let albumName: String
    let artistName: String
    let releaseDate: String
    
    init(album: Album) {
        
        albumName = album.name
        artistName = album.artistName
        if let date = AlbumViewModel.dateFormatter.date(from: album.releaseDate) {
            releaseDate = AlbumViewModel.monthFirstDateFormatter.string(from: date)
        } else {
            releaseDate = "Unknown"
        }
        imageURL = album.artworkUrl100
    }
    
    
}
