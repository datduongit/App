//
//  HomeDataToHome.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Networking

struct HomeDataToHome: IConverter {
    
    typealias SourceType = HomeData
    
    typealias DestinationType = Home
    
    func convert(from sourceType: HomeData) -> Home {
        var home = Home()
        home.priority = sourceType.priority ?? 0
        return home
    }
}
