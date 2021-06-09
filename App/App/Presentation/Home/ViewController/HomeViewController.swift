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
    
    override func setupUI() {
        messageLabel.isHidden = true
        messageLabel.layer.cornerRadius = 16
        messageLabel.layer.masksToBounds = true
    }
    
    override func bind() {
        super.bind()
        guard let viewModel = viewModel as? HomeViewModel else {
            return
        }
        
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
            .bind(to: viewModel.fetchData)
            .disposed(by: disposeBag)
        
        viewModel
            .homeModels
            .bind(onNext: { data in
                print(data.first?.priority ?? 0)
            })
            .disposed(by: disposeBag)
        
        isLoading
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: {
                print($0)
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
