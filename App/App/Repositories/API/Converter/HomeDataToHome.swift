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
        let home = Home()
        return home
    }
}
