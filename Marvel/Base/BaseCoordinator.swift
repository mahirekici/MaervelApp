
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

class BaseCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    private(set) var childCoordinators = NSHashTable<AnyObject>(options: .weakMemory)
    
    func start() {
        preconditionFailure("should be override.")
    }
    
    func start(coordinator: Coordinator) {
        childCoordinators.add(coordinator as AnyObject)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func removeChildCoordinators() {
        childCoordinators.allObjects
            .compactMap { $0 as? Coordinator }
            .forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAllObjects()
    }
    
    func didFinish(coordinator: Coordinator) {
        childCoordinators.remove(coordinator as AnyObject)
    }
}

private var navigationControllerKey: UInt8 = 0

extension BaseCoordinator {
    //referans https://medium.com/@marcosantadev/stored-properties-in-swift-extensions-615d4c5a9a58
    
    var navigationController: UINavigationController {
        get {
            if let navController = objc_getAssociatedObject(self, &navigationControllerKey) as? UINavigationController {
                return navController

            } else if let parent = parentCoordinator {
                return parent.navigationController

            } else {
                let newNavigationController = UINavigationController()
                self.navigationController = newNavigationController
                return newNavigationController
            }
        }

        set {
            objc_setAssociatedObject(self, &navigationControllerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
