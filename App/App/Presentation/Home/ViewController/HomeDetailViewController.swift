//
//  HomeDetailViewController.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//
import Core
import UIKit

class HomeDetailViewController: BaseViewController {
    
    @IBOutlet weak var actionBack: UIButton!
    
    private let viewModel: HomeDetailViewModel
    
    init(viewModel: HomeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        title = "Home Detail"
    }
    
    override func bind() {
        actionBack.rx.tap
            .bind(to: self.viewModel.popToHome)
            .disposed(by: self.disposeBag)
    }
}
