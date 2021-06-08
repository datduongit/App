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
    
    let repo: IHomeRepo
    
    /// Transforms
    let homeModels = PublishRelay<[Home]>()
    let fetchData = PublishRelay<Void>()
    let navToDetail = PublishRelay<Void>()
    
    private let activityIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    
    
    init(repo: IHomeRepo) {
        self.repo = repo
        super.init()
    }
    
    override func bind() {
        fetchData
            .flatMapLatest { [unowned self] in
                return self.repo
                    .getHomeService()
                    .trackActivity(activityIndicator)
            }
            .bind(to: homeModels)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asObservable()
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
    }
}
