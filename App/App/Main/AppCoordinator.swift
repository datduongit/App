//
//  AppCoordinator.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import Core
import Swinject
import RxSwift

class AppCoordinator: Coordinator {
    
    override var root: Presentable {
        return rootVC
    }
    
    private lazy var rootVC: SplashViewController = {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController(viewModel: viewModel)
        
        viewModel
            .actionContinue
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] in
                self?.runAppFlow()
            })
            .disposed(by: disposeBag)
        
        return viewController
    }()
    
    private let prefs: Preference
    private let container: Container
    
    init(router: Router, container: Container) {
        self.prefs = .default
        self.container = container
        super.init(router: router, navigationType: .newFlow(hideBar: true))
        
        bind()
        bindAppState()
    }
    
    private func bind() {}
    
    private func bindAppState() {
        AppStateEvent.default.state
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.trigger(state: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func trigger(state: AppState) {
        switch state {
        case .main:
            runMainFlow()
        default: break
        }
    }
}

extension AppCoordinator {
    
    private func runAppFlow() {
        /// check exist account
        if true {
            runSignUpFlow()
        }
    }
    
    private func runSignUpFlow() {
        let signupCoordinator = SignupCoordinator(router: router, navigationType: .newFlow(hideBar: false), container: container)
        setRootChild(coordinator: signupCoordinator, hideBar: false)
    }
    
    private func runSignInFlow() {
        let signinCoordinator = SigninCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        setRootChild(coordinator: signinCoordinator, hideBar: false)
    }
    
    private func runMainFlow() {
        let mainCoordinator = MainCoordinator(router: router, navigationType: .newFlow(hideBar: false), container: container)
        setRootChild(coordinator: mainCoordinator, hideBar: false)
    }
}
