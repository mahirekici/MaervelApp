
import UIKit

class HomeCoordinator: BaseCoordinator {
    
    let homeNetwork  : HomeRepository  = HomeRepositoryImp()
    
    let detailNetwork  : DetailRepository =  DetailRepositoryImp()
    
    fileprivate lazy var homeViewModel: HomeViewModel = {
        let vm = HomeViewModel()
        vm.coordinator = self
        vm.repository = homeNetwork
        return vm
    }()
    
    fileprivate lazy var detailViewModel: DetailViewModel = {
        let vm = DetailViewModel()
        vm.coordinator = self
        vm.repository =  detailNetwork
        return vm
    }()
    
    
    //her screen için bir storyborad üretilebilir
    override func start() {
       // let homeVC: HomeViewController = UIStoryboard.Main.instantiateViewController()
        let homeVC: HomeViewController = HomeViewController.instantiateViewController()
        
        homeVC.viewModel = homeViewModel
        navigationController.setViewControllers([homeVC], animated: false)
    }
}

extension HomeCoordinator {
    
    func showDetail(to character: Character) {
        let detailVC: DetailViewController = DetailViewController.instantiateViewController()

        detailVC.viewModel = detailViewModel
        detailVC.character = character
        navigationController.pushViewController(detailVC, animated: true)
    }
}
