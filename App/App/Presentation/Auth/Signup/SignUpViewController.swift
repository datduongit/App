//
//  SignUpViewController.swift
//  App
//
//  Created by Edric D. on 08/06/2021.
//

import UIKit
import Core
import RxSwift

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func setupUI() {
        title = "Sign Up"
    }
    
    override func bind() {
        guard let viewModel = viewModel as? SignUpViewModel else {
            return
        }
        
        signupButton.rx.tap
            .bind(to: viewModel.actionSignup)
            .disposed(by: disposeBag)
    }
}
