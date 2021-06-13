
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(urlString: String) {
        if let url = URL(string: urlString) {
            kf.setImage(with: url)
        } else {
            image = nil
        }
    }
    
    func makeRounded() {

        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}

