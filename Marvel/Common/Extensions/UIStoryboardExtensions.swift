

import UIKit


public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
    static func instantiateNavViewController(_ bundle: Bundle?) -> UINavigationController

}

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        
      
        
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
    
    static func instantiateNavViewController(_ bundle: Bundle? = nil) -> UINavigationController {
           let fileName = defaultFileName
           let storyboard = UIStoryboard(name: fileName, bundle: bundle)
           
           guard let nav = storyboard.instantiateInitialViewController() as? UINavigationController else {
               
               fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
           }
        return nav
       }
    
    
    
        func add(child: UIViewController, container: UIView) {
            addChild(child)
            child.view.frame = container.bounds
            container.addSubview(child.view)
            child.didMove(toParent: self)
        }
    
        func remove() {
            guard parent != nil else {
                return
            }
            willMove(toParent: nil)
            removeFromParent()
            view.removeFromSuperview()
        }
}
