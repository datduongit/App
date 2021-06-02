//
//  HomeDetailViewController.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//
import Core
import UIKit

class HomeDetailViewController: BaseViewController {
    
    let viewModel: HomeDetailViewModel!
    
    @IBOutlet weak var actionBack: UIButton!
    
    init(viewModel: HomeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind() {
        actionBack.rx.tap
            .bind(to: viewModel.popToHome)
            .disposed(by: disposeBag)
    }
}
