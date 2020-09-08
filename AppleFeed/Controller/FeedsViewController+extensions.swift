
import UIKit

extension FeedsViewController {
    
    enum Section {
        case main
    }

    func columnCount(for width: CGFloat) -> Double {
        let wideMode = width > 500
        if isGrid {
            return wideMode ? 4.0 : 2.0
        } else {
            return wideMode ? 2.0 : 1.0
        }
    }
    
    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {  (_, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let columns = self.columnCount(for: layoutEnvironment.container.effectiveContentSize.width)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(1.0/columns)),
                                                           heightDimension: .fractionalHeight(1.0))


            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            return section
        }
        
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AlbumViewModel>(collectionView: collectionView) { (collectionView, indexPath, albumViewModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as? AlbumCell else { fatalError("Cannot create new cell")
            }
//            let albumViewModel = self.albumsViewModel[indexPath.row]
            cell.albumViewModel = albumViewModel
//            cell.albumName.text = albumViewModel.artistName
//            cell.artistName.text = albumViewModel.artistName
//            cell.releaseDate.text = albumViewModel.releaseDate
//            cell.albumArt.loadImage(from: albumViewModel.imageURLString, nsImageCache: self.nsImageCache, completionHandler: { image in
//                cell.albumArt.image = image
//            })
//            AlbumArtCache.shared.loadImage(from: albumViewModel.imageURLString) { image in
//                cell.albumArt.image = image
//            }
//            cell.albumArt.layer.cornerRadius = 10
//            cell.loadImage(urlString: albumViewModel.imageURLString)
            return cell
        }
    }
    
    func updateAlbums(animate: Bool = false) {
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, AlbumViewModel>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(albumsViewModel, toSection: .main)

        dataSource.apply(initialSnapshot, animatingDifferences: animate)
    }
}
