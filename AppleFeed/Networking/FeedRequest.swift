
import Foundation

struct FeedRequest {
    
    let resourceURL: URL
    
    init(countryCode: String = "us", numAlbums: Int = 50) {
        let resourceString = "https://rss.itunes.apple.com/api/v1/\(countryCode)/apple-music/coming-soon/all/\(numAlbums)/explicit.json"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func getAlbums(completion: @escaping (Result<[Album], FeedRequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let albumJsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let feedResponses = try decoder.decode(Feed.self, from: albumJsonData)
                let albums = feedResponses.feed.results.sorted { $0.releaseDate < $1.releaseDate }
                completion(.success(albums))
            } catch {
                completion(.failure(.cannotDecodeData))
            }
        }
        dataTask.resume()
    }
    
    enum FeedRequestError: Error {
        case noDataAvailable
        case cannotDecodeData
    }
}

