//
//  SignupCoordinator.swift
//  App
//
//  Created by Edric D. on 08/06/2021.
//

import UIKit
import Core
import Swinject
import RxSwift
import RxCocoa

class SignupCoordinator: Coordinator {
    
    private let container: Container
    
    override var root: Presentable {
        return rootVC
    }
    
    private lazy var rootVC: UIViewController = {
        let viewModel = SignUpViewModel()
        
        viewModel.actionSignup
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] in
                self?.runMainFlow()
            })
            .disposed(by: disposeBag)
        
        return SignUpViewController(viewModel: viewModel)
    }()
    
    init(router: Router, navigationType: Coordinator.NavigationType, container: Container) {
        self.container = container
        super.init(router: router, navigationType: navigationType)
    }
    
    private func runMainFlow() {
        let mainCoordinator = MainCoordinator(router: router, navigationType: .newFlow(hideBar: true), container: container)
        setRootChild(coordinator: mainCoordinator, hideBar: true)
    }
}
