
import UIKit

class AlbumArtCache {
    static let shared = AlbumArtCache()
    private init () {}
    
    let cache: NSCache<NSString, UIImage> = NSCache()
    
    func addImage(key: NSString, image: UIImage) {
        self.cache.setObject(image, forKey: key)
    }
    func getImage(key: NSString) -> UIImage? {
        return self.cache.object(forKey: key)
    }
    
    func loadImage(from urlString: String, completionHandler: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let artworkUrl = urlString as NSString
        if let cachedImage = self.getImage(key: artworkUrl) {
            DispatchQueue.main.async {
                completionHandler(cachedImage)
            }
        } else {
            ImageRequest(url: url).loadAndDecode { image in
                if let image = image {
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                    self.cache.setObject(image, forKey: urlString as NSString)
                }
            }
        }
    }
}
