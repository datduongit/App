//
//  SettingCoordinator.swift
//  App
//
//  Created by Edric D. on 08/06/2021.
//

import Core

class SettingCoordinator: Coordinator {
    override var root: Presentable {
        let viewModel = SettingViewModel()
        return SettingViewController(viewModel: viewModel)
    }
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        super.init(router: router, navigationType: navigationType)
    }
}
