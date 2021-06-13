

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class BaseViewController<T: ViewModel>: UIViewController ,StoryboardInstantiable{
    
    lazy var disposeBag = DisposeBag()
    
    var viewModel: T!
    
    lazy var keyWindow: UIWindow? = {
        UIApplication.shared.windows.first { $0.isKeyWindow }
    }()
    
    lazy var loading = makeActivityIndicatorView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure(viewModel: viewModel)
    }
    
    // MARK: - Configure
    
    func configure(viewModel: T) {
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                isLoading ? self.startLoading() : self.stopLoading()
            }).disposed(by: disposeBag)
    }
    
    func showError(errorMessage: String, completionHandler: PopupCompletionHandler? = nil) {
        stopLoading()
        showPopup(title: "error_title".localized, message: errorMessage, completionHandler: completionHandler)
    }
    
    func startLoading() {
        if !(loading?.isAnimating ?? false) { loading?.startAnimating() }
    }
    
    func stopLoading() {
        loading?.stopAnimating()
    }
}

extension BaseViewController {
    
    private func makeActivityIndicatorView() -> NVActivityIndicatorView? {
        guard let window = self.keyWindow else { return nil }
        
        let loading = NVActivityIndicatorView(frame: CGRect.zero, type: .lineScalePulseOut, color: .blue, padding: 10)
        window.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        return loading
    }
}
