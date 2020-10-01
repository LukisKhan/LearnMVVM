
import Foundation

struct Feed: Decodable {
    let feed: AlbumFeed
}

struct AlbumFeed: Decodable {
    let results: [Album]
}

struct Album: Decodable {
    
    let artistName: String
    let name: String
    let artworkUrl100: String
    let releaseDate: String
}
