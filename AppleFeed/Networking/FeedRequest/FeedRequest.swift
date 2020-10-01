
import Foundation

struct FeedRequest {
    
    func getAlbums(completion: @escaping (Result<[Album], FeedRequestError>) -> Void) {
        let feedResource = FeedResouce()
        let modelRequest = ModelRequest(resource: feedResource)
        modelRequest.loadAndDecode { (feed) in
            guard let feed = feed else {
                completion(.failure(.noDataAvailable))
                return
            }
            let albumsSorted = feed.feed.results.sorted { $0.releaseDate < $1.releaseDate }
            completion(.success(albumsSorted))
        }
 

    }
    
    enum FeedRequestError: Error {
        case noDataAvailable
        case cannotDecodeData
    }
}

