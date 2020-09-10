//
//  ImageRequest.swift
//  AppleFeed
//
//  Created by Rave BizzDev on 9/10/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import UIKit

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
}

extension ImageRequest: NetworkRequest {
    func decode(data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func loadAndDecode(withCompletion completion: @escaping (UIImage?) -> Void) {
        load(url: url, completion: completion)
    }
}
