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

class HomeViewController: BaseViewController {
    
    private let viewModel: HomeViewModel
    
    @IBOutlet private weak var actionDetail: UIButton!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind() {
        actionDetail
            .rx.tap
            .bind(to: viewModel.fetchData)
            .disposed(by: disposeBag)
        
        viewModel
            .homeModels
            .bind(onNext: { data in
                print(data.first?.priority)
            })
            .disposed(by: disposeBag)
    }
}
