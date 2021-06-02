//
//  SplashViewModel.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import RxSwift
import RxRelay

class SplashViewModel {
    let viewDidLoad = PublishRelay<Void>()
    let actionContinue = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        viewDidLoad
            .delay(2, scheduler: MainScheduler.asyncInstance)
            .bind(to: actionContinue)
            .disposed(by: disposeBag)
    }
}
