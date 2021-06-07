//
//  HomeDetailViewController.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//
import Core
import UIKit

class HomeDetailViewController: BaseViewController<HomeDetailViewModel> {
    
    @IBOutlet weak var actionBack: UIButton!
    
    override func bind() {
        actionBack.rx.tap
            .bind(to: self.viewModel.popToHome)
            .disposed(by: self.disposeBag)
    }
}
