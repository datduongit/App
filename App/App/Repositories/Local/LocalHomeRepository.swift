//
//  LocalHomeRepository.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import RxSwift

class LocalHomeRepository: IHomeRepo {
    func getHomeService() -> Single<[Home]> {
        return Observable.from([]).asSingle()
    }
    
}
