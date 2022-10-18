import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
                print("Get image from cache")
                return
            }
            
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async() { () -> Void in
                    self.image = image
                    print("Get image from url")
                }
            }
            .resume()
        }
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
