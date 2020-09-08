//
//  ImageCache.swift
//  AppleFeed
//
//  Created by Rave BizzDev on 9/7/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import UIKit

struct AlbumArtCache {
    static let shared = AlbumArtCache()
    private init () {}
    
    let cache: NSCache<NSString, UIImage> = NSCache()
    
    func addImage(key: NSString, image: UIImage) {
        self.cache.setObject(image, forKey: key)
    }
    func getImage(key: NSString) -> UIImage? {
        return self.cache.object(forKey: key)
    }
    
    func loadImage(from urlString: String, completionHandler: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let artworkUrl = urlString as NSString
        if let cachedImage = self.getImage(key: artworkUrl) {
            DispatchQueue.main.async {
                completionHandler(cachedImage)
            }
        } else {
            guard let placeholder = UIImage(named: "loading") else { return }
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let myData = data, let image = UIImage(data: myData) {
                    DispatchQueue.main.async {
                        //                           self.image = image
                        completionHandler(image)
                    }
                    self.cache.setObject(image, forKey: urlString as NSString)
                }
            }
            task.resume()
        }
    }
}
