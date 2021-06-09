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
    
    override func setupUI() {
        title = "Home Detail"
    }
    
    override func bind() {
        guard let viewModel = viewModel as? HomeDetailViewModel else {
            return
        }
        
        actionBack.rx.tap
            .bind(to: viewModel.popToHome)
            .disposed(by: self.disposeBag)
    }
}
