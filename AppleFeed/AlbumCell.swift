//
//  AlbumCell.swift
//  AppleFeed
//
//  Created by Rave BizzDev on 9/6/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    static let reuseIdentifier = String(describing: AlbumCell.self)
    
}
