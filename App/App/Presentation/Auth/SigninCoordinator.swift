//
//  SigninCoordinator.swift
//  App
//
//  Created by Edric D. on 08/06/2021.
//
import Core
import UIKit

class SigninCoordinator: Coordinator {
    
    override var root: Presentable {
        return rootVC
    }
    
    private lazy var rootVC: UIViewController = {
        let viewModel = SignInViewModel()
        let viewController = SignInViewController(viewModel: viewModel)
        return viewController
    }()
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        super.init(router: router, navigationType: navigationType)
    }
}
