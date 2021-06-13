

import UIKit

class DetailViewController: BaseViewController<DetailViewModel> {
    
    var character : Character?
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func configure(viewModel: DetailViewModel) {
        super.configure(viewModel: viewModel)
        
        setHeroDetails()
        
        
        viewModel
            .comics
            .asDriver()
            .drive(tableView
                    .rx
                    .items(cellIdentifier: "ComicsListCell", cellType: ComicsListCell.self)) { (_, character, cell) in
                cell.configureCell(with: character)
            }
            .disposed(by: disposeBag)
        
       
        
        
        viewModel.loadData(id: (character?.id)!)
    }
    
    
    func setHeroDetails() {
        name.text = character?.name
        desc.text = character?.description
        
        photo.setImage(urlString: character!.thumbnail)
        photo.makeRounded()
       
    }
}
