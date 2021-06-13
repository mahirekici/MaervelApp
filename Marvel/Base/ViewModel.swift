
import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    lazy var disposeBag = DisposeBag()
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    required public init() {
        
    }
}
