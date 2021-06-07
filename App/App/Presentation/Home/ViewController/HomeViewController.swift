//
//  HomeViewController.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import UIKit
import Core
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet private weak var actionDetail: UIButton!
    
    override func bind() {
        actionDetail
            .rx.tap
            .bind(to: self.viewModel.fetchData)
            .disposed(by: disposeBag)
        
        self.viewModel
            .homeModels
            .bind(onNext: { data in
                print(data.first?.priority ?? 0)
            })
            .disposed(by: disposeBag)
        
        self.viewModel
            .isLoading
            .asDriverOnErrorJustComplete()
            .drive(onNext: {
                print("isLoading: \($0)")
            })
            .disposed(by: disposeBag)
            
    }
}
