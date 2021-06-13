
import UIKit

class ComicsListCell: UITableViewCell {
    
    
  
    @IBOutlet weak var title: UILabel!
    
   // @IBOutlet weak  var desc: UILabel!
    
    
    func configureCell(with c: Comics) {
        title.text = c.title
       // desc.text = c.description
        
    }
}
