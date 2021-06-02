//
//  DIContainer.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import Swinject
import SwinjectAutoregistration

open class DIContainer {
    public static func inject(_ container: Container) {
        container.autoregister(HomeService.self, initializer: HomeService.makeProvider)
        container.autoregister(HomeRepository.self, initializer: RemoteHomeRepository.init)
    }
}
