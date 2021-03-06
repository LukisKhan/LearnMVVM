
import XCTest
@testable import AppleFeed

class AppleFeedTests: XCTestCase {

     var sut: Feed?
        
        override func setUpWithError() throws {
            let testBundle = Bundle(for: type(of: self))
            if let path = testBundle.path(forResource: "mockData", ofType: "json") {
                if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) {
                    let decoder = JSONDecoder()
                    let albumResponses = try? decoder.decode(Feed.self, from: jsonData)
                    sut = albumResponses
                }
            }
        }

        override func tearDownWithError() throws {
            sut = nil
            super.tearDown()
        }
        
        func test_DecodeAlbumModelFromMockData() {
            guard let sut = sut else { return }
            let albumDetails = sut.feed.results
            XCTAssertEqual(albumDetails.count, 1, "Album should have 1 entry")
            
        }

        func test_AlbumDetailsStoresNameAndArtistName() {
            guard let sut = sut else { return }
            let albumName = sut.feed.results.first?.name
            let artistName = sut.feed.results.first?.artistName
            XCTAssertEqual(albumName, "ballerini", "Album name should be ballerini")
            XCTAssertEqual(artistName, "Kelsea Ballerini", "Album name should be Kelsea Ballerini")
            
        }

        func test_FeedModelCanStoreArrayOfAlbums() {
            let oneAblum = Album(artistName: "",
                                 name: "Fake Album",
                                 artworkUrl100: "",
                                 releaseDate: "")
            let albums = Array(repeating: oneAblum, count: 3)
            let feed = Feed(feed: AlbumFeed(results: albums))
            
            XCTAssertTrue(feed.feed.results.count == 3, "Array of albums can be stored in Feed model")
        }
        
        
}
