//
//  HomeViewModel.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import Core
import RxSwift
import RxRelay
import Utility

class HomeViewModel: BaseViewModel {
    
    let repository: IHomeRepo
    
    /// Transforms
    let homeModels = PublishRelay<[Home]>()
    
    let fetchData = PublishRelay<Void>()
    let navToDetail = PublishRelay<Void>()
    
    
    init(repo: IHomeRepo) {
        self.repository = repo
        super.init()
    }
    
    override func bind() {
        fetchData
            .flatMapLatest { [unowned self] in
                return self.repository
                    .getHomeService()
                    .trackActivity(activityIndicator)
            }
            .bind(to: homeModels)
            .disposed(by: disposeBag)
        
    }
}
