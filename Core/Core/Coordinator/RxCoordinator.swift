import RxSwift

public protocol RxCoordinator: AnyObject {}

// TODO: Rename _BaseCoordinator and remove following line
// swiftlint:disable type_name
/// Base abstract coordinator generic over the return type of the `start` method.
open class _BaseCoordinator<Deeplink, ResultType>: UIResponder, RxCoordinator {

    /// Typealias which will allows to access a ResultType of the Coordainator by `CoordinatorName.CoordinationResult`.
    public typealias CoordinationResult = ResultType

    /// Utility `DisposeBag` used by the subclasses.
    public var disposeBag = DisposeBag()

    /// Unique identifier.
    private(set) var identifier = UUID()

    /// Dictionary of the child coordinators. Every child coordinator should be added
    /// to that dictionary in order to keep it in memory.
    /// Key is an `identifier` of the child coordinator and value is the coordinator itself.
    /// Value type is `Any` because Swift doesn't allow to store generic types in the array.
    private var childCoordinators = [UUID: Any]()

    /// Stores coordinator to the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Child coordinator to store.
    public func store<D, T>(coordinator: _BaseCoordinator<D, T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    /// Release coordinator from the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Coordinator to release.
    public func free<D, T>(coordinator: _BaseCoordinator<D, T>) {
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
    
    @discardableResult
    public func coordinate<D, T>(to coordinator: _BaseCoordinator<D, T>, with deeplink: D? = nil) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start(with: deeplink)
            .do(onNext: { [weak self] _ in
                self?.free(coordinator: coordinator)
            })
    }
    
    /// Starts job of the coordinator.
    ///
    /// - Returns: Result of coordinator job.
    open func start(with deeplink: Deeplink?) -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
    
    /// 1. Stores coordinator in a dictionary of child coordinators.
    /// 2. Calls method `start()` on that coordinator.
    /// 3. On the `onNext:` of returning observable of method `start()` removes coordinator from the dictionary.
    ///
    /// - Parameter coordinator: Coordinator to start.
    /// - Returns: Result of `start()` method.
    @discardableResult
    public func coordinate<T>(to coordinator: _BaseCoordinator<Never, T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.free(coordinator: coordinator)
            })
    }

    /// Starts job of the coordinator.
    ///
    /// - Returns: Result of coordinator job.
    open func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
    
    public override init() {}
}

typealias BaseCoordinator<ResultType> = _BaseCoordinator<Never, ResultType>
// swiftlint:enable type_name
