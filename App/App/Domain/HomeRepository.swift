//
//  HomeRepository.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import RxSwift

protocol HomeRepository {
    func getHomeService() -> Observable<[HomeModel]>
}
