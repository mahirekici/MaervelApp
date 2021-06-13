
import UIKit

class CharacterListCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    func configureCell(with character: Character) {
        name.text = character.name
        thumbnailImage.setImage(urlString: character.thumbnail)
        thumbnailImage.makeRounded()
    }
}


