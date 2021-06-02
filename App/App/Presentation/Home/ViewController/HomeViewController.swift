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
    
    let viewModel: HomeViewModel!
    
    @IBOutlet weak var actionDetail: UIButton!
    
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
    }
}
