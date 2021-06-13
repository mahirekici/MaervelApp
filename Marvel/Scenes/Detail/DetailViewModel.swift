
import UIKit
import RxSwift
import RxCocoa


class DetailViewModel: ViewModel {
    
    weak var coordinator: HomeCoordinator!
   
    var repository: DetailRepository!
    
    var comics = BehaviorRelay<[Comics]>(value: [])
    var errorMessage = BehaviorRelay<String>(value: "")    
    
    
    func loadData(id:Int) {
        self.isLoading.accept(true)
        
        self.comics.accept([])
        
        repository.fetchData(id :id) { (result) in
            self.isLoading.accept(false)
            
            switch result {
            case .success(let data):
                self.successData(l:data)
            case .failure(let error):
                self.errorMessage.accept(error.errorMessage)
            }
        }
    }
    
    func successData(l:[Comics]){
        self.comics.accept(l)
    }
  

}
