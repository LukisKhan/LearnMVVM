//
//  ModelRequest.swift
//  AppleFeed
//
//  Created by Rave BizzDev on 9/10/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import Foundation

class ModelRequest<Resource: AnyResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension ModelRequest: NetworkRequest {
    func decode(data: Data) -> Resource.ModelType? {
        return try? JSONDecoder().decode(Resource.ModelType.self, from: data)
    }
    
    func loadAndDecode(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        load(url: resource.url, completion: completion)
    }
}
