//
//  HomeViewModel.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import Core
import RxRelay
import Utility

class HomeViewModel: BaseViewModel {
    
    // Input
    let repository: HomeRepository!
    
    // Output
    let fetchData = PublishRelay<Void>()
    let navToDetail = PublishRelay<Void>()
    
    init(repo: HomeRepository) {
        self.repository = repo
        super.init()
    }
    
    override func bind() {
        fetchData
            .flatMapLatest { [unowned self] in
                return self.repository.getHomeService()
            }
            .mapToVoid()
            .bind(to: navToDetail)
            .disposed(by: disposeBag)
    }
}
