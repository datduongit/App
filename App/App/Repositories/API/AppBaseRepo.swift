//
//  AppBaseRepo.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Foundation

class AppBaseRepo {
    func invokeService<T: AppApiService>(_ service: T.Type) -> T {
        return AppApiServiceFactory.create(service)
    }
}
