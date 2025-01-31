import UIKit

extension UIImageView {
    func downloadImage(from url: URL) {
        let session = URLSession(configuration: .default, delegate: SecureURLSessionDelegate(), delegateQueue: nil)

        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
