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
    
    private let viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        title = "Sign Up"
    }
    
    override func bind() {
        signupButton.rx.tap
            .bind(to: viewModel.actionSignup)
            .disposed(by: disposeBag)
    }
}
