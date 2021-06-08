//
//  SignInViewController.swift
//  App
//
//  Created by Edric D. on 08/06/2021.
//

import UIKit
import Core

class SignInViewController: BaseViewController {
    @IBOutlet weak var loginAction: UIButton!
    
    private let viewModel: SignInViewModel!
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
