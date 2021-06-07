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

class HomeViewModel: BaseViewModel, BaseViewModelType {
    var input: HomeViewModelInput
    var output: HomeViewModelOutput
    
    struct HomeViewModelInput {
        let repo: IHomeRepo
    }
    
    struct HomeViewModelOutput {
        let navToDetail: Observable<Void>
    }
    
    /// Transforms
    let homeModels = PublishRelay<[Home]>()
    let fetchData = PublishRelay<Void>()
    let navToDetail = PublishRelay<Void>()
    
    private let activityIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    
    
    init(repo: IHomeRepo) {
        self.input = HomeViewModelInput(repo: repo)
        self.output = HomeViewModelOutput(navToDetail: navToDetail.asObservable())
        super.init()
    }
    
    override func bind() {
        fetchData
            .flatMapLatest { [unowned self] in
                return self.input.repo
                    .getHomeService()
                    .trackActivity(activityIndicator)
            }
            .bind(to: homeModels)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asObservable()
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
    }
}
