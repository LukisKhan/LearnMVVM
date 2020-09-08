
import UIKit


class AlbumViewModel: Hashable {
    static func == (lhs: AlbumViewModel, rhs: AlbumViewModel) -> Bool {
        return lhs.albumName == rhs.albumName
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(albumName)
    }
    private(set) var album: Album
    
//    static func fetchAlbums() -> [AlbumViewModel] {
//        let feedRequest = FeedRequest()
//        var fetchedAlbums: [Album] = []
//        feedRequest.getAlbums { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let albums):
//                numFetched += 1
//                print(fetchAlbums())
//                print("in view model \(AlbumViewModel.numFetched) times")
//                fetchedAlbums = albums
//            }
//        }
//        var fetchedAlbumsViewModels = [AlbumViewModel]()
//        for album in fetchedAlbums {
//            let albumViewModel = AlbumViewModel(album: album)
//            fetchedAlbumsViewModels.append(albumViewModel)
//        }
//        print(fetchedAlbumsViewModels)
//        return fetchedAlbumsViewModels
//    }
//    static var numFetched = 0
    
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
    
    let imageURLString: String
    let albumName: String
    let artistName: String
    let releaseDate: String
//    let imageView: UIImageView

    
    init(album: Album) {
        self.album = album
        albumName = album.name
        artistName = album.artistName
        if let date = AlbumViewModel.dateFormatter.date(from: album.releaseDate) {
            releaseDate = AlbumViewModel.monthFirstDateFormatter.string(from: date)
        } else {
            releaseDate = "Unknown"
        }
        imageURLString = album.artworkUrl100
        
        print(album.name)
    }
    
    
    func formattedDate(releaseDate: String) -> String {
        if let date = AlbumViewModel.dateFormatter.date(from: releaseDate) {
            return AlbumViewModel.monthFirstDateFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
    
//    func loadImage(imageURLString: String) {
//        AlbumArtCache.shared.loadImage(from: imageURLString) { image in
//            self.imageView.image = image
//         }
//    }
//        cell.albumArt.loadImage(from: albumViewModel.imageURLString, nsImageCache: self.nsImageCache, completionHandler: { image in
//            cell.albumArt.image = image
//        })
//        cell.albumArt.layer.cornerRadius = 10
    
    
}
