//
//  HomeApiService.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Foundation

class HomeApiService: AppAPIService {
    func getListHomeInfo(complete: @escaping ([HomeData]) -> Void) {
        var result: [HomeData] = []
        for i in 0...100 {
            var item = HomeData()
            item.priority = i
            result.append(item)
        }
        complete(result)
    }
}
