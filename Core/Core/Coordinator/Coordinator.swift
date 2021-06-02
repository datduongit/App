import Foundation
import RxSwift
import RxRelay

open class Coordinator: NSObject {
    public enum NavigationType {
        case currentFlow // push
        case newFlow(hideBar: Bool) // present, set root
    }
    
    public let router: Router

    public private(set) var childCoordinators: [Coordinator] = []
    public let navigationType: NavigationType

    open var disposeBag = DisposeBag()

    let deeplinkSubject = BehaviorRelay<String?>(value: nil)
    var deeplinkDisposeBag = DisposeBag()

    open var root: Presentable {
        fatalError("need root view presentable")
    }
    
    public init(router: Router, navigationType: NavigationType) {
        self.router = router
        self.navigationType = navigationType
        
        super.init()

        if case .newFlow(let hideBar) = navigationType {
            router.setRoot(root, hideBar: hideBar)
        }
    }

    public func resetDeeplink() {
        for child in childCoordinators {
            child.deeplinkDisposeBag = DisposeBag()
        }
        deeplinkSubject.accept(nil)
    }

    public func addChild(_ coordinator: Coordinator) {
        deeplinkSubject
            .accept(coordinator.deeplinkSubject.value)

        childCoordinators.append(coordinator)
    }

    private func removeChild(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }

    public func setRootChild(coordinator: Coordinator, hideBar: Bool) {
        addChild(coordinator)
        router.setRoot(coordinator, hideBar: hideBar) { [weak self, weak coordinator] in
            guard let coord = coordinator else { return }
            self?.removeChild(coord)
        }
    }

    public func pushChild(coordinator: Coordinator, animated: Bool, onRemove: (() -> Void)? = nil) {
        addChild(coordinator)

        router.push(coordinator, animated: animated) { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            onRemove?()
            self.removeChild(coordinator)
        }
    }
    
    // make sure to always call dismissChild after
    public func presentChild(coordinator: Coordinator, animated: Bool) {
        addChild(coordinator)
        router.present(coordinator, animated: animated)
    }

    public func dismissChild(_ coordinator: Coordinator, animated: Bool) {
        coordinator.toPresentable().presentingViewController?.dismiss(animated: animated, completion: nil)
        removeChild(coordinator)
    }
    
    public func popChild(_ coordinator: Coordinator, animated: Bool) {
        coordinator.toPresentable().navigationController?.popViewController(animated: animated)
        removeChild(coordinator)
    }
}

extension Coordinator: Presentable {
    public func toPresentable() -> UIViewController {
        switch navigationType {
        case .currentFlow:
            return root.toPresentable()
        case .newFlow:
            return router.toPresentable()
        }
    }
}
