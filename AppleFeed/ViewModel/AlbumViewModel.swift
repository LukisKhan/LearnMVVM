
import UIKit


class AlbumViewModel: Hashable {
    
    private(set) var album: Album
    
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
    
    static func formattedDate(releaseDate: String) -> String {
        if let date = AlbumViewModel.dateFormatter.date(from: releaseDate) {
            return AlbumViewModel.monthFirstDateFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
    
    let imageURLString: String
    let albumName: String
    let artistName: String
    let releaseDate: String

    
    init(album: Album) {
        self.album = album
        albumName = album.name
        artistName = album.artistName
        releaseDate = AlbumViewModel.formattedDate(releaseDate: album.releaseDate)
        imageURLString = album.artworkUrl100
    }
    

    static func fetchFeeds( viewModel: inout [AlbumViewModel] ) {
            var fetchedAlbumsViewModels = [AlbumViewModel]()
            let semaphore = DispatchSemaphore(value: 0)
            let feedRequest = FeedRequest()
            feedRequest.getAlbums { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let albums):
                    fetchedAlbumsViewModels = albums.map({ return AlbumViewModel(album: $0) })
                    semaphore.signal()
                }
        }
        _ = semaphore.wait(timeout: .distantFuture)
        viewModel = fetchedAlbumsViewModels
    }
    
}


extension AlbumViewModel {
    static func == (lhs: AlbumViewModel, rhs: AlbumViewModel) -> Bool {
        return lhs.albumName == rhs.albumName
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(albumName)
    }
}
