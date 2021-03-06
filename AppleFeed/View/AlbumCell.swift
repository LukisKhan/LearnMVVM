
import UIKit

class AlbumCell: UICollectionViewCell {
    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    static let reuseIdentifier = String(describing: AlbumCell.self)
    
    var albumViewModel: AlbumViewModel! {
        didSet {
            albumName.text = albumViewModel.albumName
            artistName.text = albumViewModel.artistName
            releaseDate.text = albumViewModel.releaseDate
            loadImage(urlString: albumViewModel.imageURLString)
        }
    }
    
    private func loadImage(urlString: String) {
        if albumArt.image == nil {
            guard let placeholder = UIImage(named: "loading") else { fatalError() }
            DispatchQueue.main.async {
                self.albumArt.image = placeholder
            }
        }
        AlbumArtCache.shared.loadImage(from: urlString) { image in
            self.albumArt.image = image
        }
        albumArt.layer.cornerRadius = 10
    }
}
