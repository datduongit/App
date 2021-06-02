//
//  LocalHomeRepository.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import RxSwift

class LocalHomeRepository: HomeRepository {
    func getHomeService() -> Observable<[HomeModel]> {
        return .empty()
    }
    
}
