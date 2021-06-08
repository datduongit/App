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
import Logger

class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var actionDetail: UIButton!
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        messageLabel.isHidden = true
        messageLabel.layer.cornerRadius = 16
        messageLabel.layer.masksToBounds = true
    }
    
    override func bind() {
        
//        actionDetail
//            .rx.tap
//            .bind(onNext: { [weak self] _ in
//                if let fcmToken = AppDelegate.shared.fcmToken {
//                    UIPasteboard.general.string = fcmToken
//                    Log.d(fcmToken)
//                    self?.showMessageCopy()
//                }
//            })
//            .disposed(by: disposeBag)
        
        actionDetail
            .rx.tap
            .bind(to: viewModel.navToDetail)
            .disposed(by: disposeBag)
        
        viewModel
            .homeModels
            .bind(onNext: { data in
                print(data.first?.priority ?? 0)
            })
            .disposed(by: disposeBag)
    }
    
    private func showMessageCopy() {
        if !messageLabel.isHidden {
            return
        }
        messageLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.messageLabel.isHidden = true
        }
    }
}
