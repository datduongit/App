//
//  HomeCoordinator.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import Core
import RxSwift
import UIKit
import Swinject

class HomeCoordinator: Coordinator {
    
    let container: Container
    
    override var root: Presentable {
        return rootVC
    }

    private lazy var rootVC: HomeViewController = {
        let viewModel = HomeViewModel(repo: container.resolve(HomeRepository.self)!)
        
        viewModel
            .navToDetail
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: pushToDetail)
            .disposed(by: disposeBag)
        
        return HomeViewController(viewModel: viewModel)
    }()

    init(router: Router, navigationType: Coordinator.NavigationType, container: Container) {
        self.container = container
        super.init(router: router, navigationType: .newFlow(hideBar: false))
        
    }
    
    private func pushToDetail() {
        let viewModel = HomeDetailViewModel()
        let viewController = HomeDetailViewController(viewModel: viewModel)
        
        viewModel
            .popToHome
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] in
                self?.router.pop()
            })
            .disposed(by: disposeBag)
        
        router.push(viewController)
    }

}
