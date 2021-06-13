
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var characterListTableView: UITableView!
    
    override func configure(viewModel: HomeViewModel) {
        super.configure(viewModel: viewModel)
        
        viewModel
            .characters
            .asDriver()
            .drive(characterListTableView
                    .rx
                    .items(cellIdentifier: "cell", cellType: CharacterListCell.self)) { (_, character, cell) in
                cell.configureCell(with: character)
            }
            .disposed(by: disposeBag)
        
        characterListTableView
            .rx
            .modelSelected(Character.self)
            .subscribe { character in
                viewModel.showDetails(to: character)
            }
            .disposed(by: disposeBag)
        
        characterListTableView
            .rx
            .willDisplayCell
            .subscribe(onNext: { _, indexPath in
                viewModel.checkDidEnd(indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.loadData()
    }
}
