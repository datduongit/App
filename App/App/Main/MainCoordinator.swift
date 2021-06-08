//
//  MainCoordinator.swift
//  App
//
//  Created by Edric D. on 08/06/2021.
//

import Core
import UIKit
import RxSwift
import RxCocoa
import Swinject

class MainCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private let container: Container
    
    private var tabs = [UIViewController : Coordinator]()

    override var root: Presentable {
        return tabBarController
    }
    
    private lazy var homeCoordinator: Coordinator = {
        let nav = UINavigationController()
        nav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "info.circle"), tag: 0)
        let router = Router(navigationController: nav)
        let coordinator = HomeCoordinator(router: router, navigationType: .newFlow(hideBar: false), container: container)
        
        addChild(coordinator)
        return coordinator
    }()
    
    private lazy var settingCoordinator: Coordinator = {
        let nav = UINavigationController()
        nav.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "info.circle"), tag: 1)
        let router = Router(navigationController: nav)
        
        let coordinator = SettingCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        addChild(coordinator)
        return coordinator
    }()
    
    init(router: Router, navigationType: Coordinator.NavigationType, container: Container) {
        self.tabBarController = UITabBarController()
        self.container = container
        super.init(router: router, navigationType: navigationType)
        setTabs()
    }
    
    private func setTabs() {
        tabs = [:]
        
        let vcs = [homeCoordinator, settingCoordinator].map { coordinator -> UIViewController in
            let viewController = coordinator.toPresentable()
            tabs[viewController] = coordinator
            
            return viewController
        }
        
        tabBarController.setViewControllers(vcs, animated: false)
    }
}
