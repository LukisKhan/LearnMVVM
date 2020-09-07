//
//  UIImage+load.swift
//  AppleFeed
//
//  Created by Rave BizzDev on 9/6/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//
import UIKit

extension UIImageView {
    
    func loadImage(from urlString: String, nsImageCache: NSCache<NSString, UIImage>, completionHandler: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let artworkUrl = urlString as NSString
        if let cachedImage = nsImageCache.object(forKey: artworkUrl) {
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
                        self.image = image
                    }
                    nsImageCache.setObject(image, forKey: urlString as NSString)
                }
            }
            task.resume()
        }
    }
    
}

