
import UIKit

class FeedsViewController: UICollectionViewController {

    @IBOutlet weak var gridBarButton: UIBarButtonItem!
    @IBAction func toggleGridLayout(_ sender: Any) {
        isGrid = !isGrid
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations:  {
            self.gridBarButton.title = self.isGrid ? "List" : "Grid"
            self.collectionView.collectionViewLayout = self.configureLayout()
        })
    }
    @IBAction func refresh(_ sender: Any) {
        reloaded = true
//        AlbumViewModel.fetchFeeds(viewModel: &albumsViewModel)
        fetchFeeds()
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AlbumViewModel>!
    var isGrid = false
    var reloaded = false
    var albumsViewModel = [AlbumViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.updateAlbums(animate: self.reloaded)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music Coming Soon"
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
//        AlbumViewModel.fetchFeeds(viewModel: &albumsViewModel)
        fetchFeeds()
    }

    private func fetchFeeds() {
        let feedRequest = FeedRequest()
        feedRequest.getAlbums { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let albums):
                self?.albumsViewModel = albums.map( { return AlbumViewModel(album: $0)} )
            }
        }
    }
}
