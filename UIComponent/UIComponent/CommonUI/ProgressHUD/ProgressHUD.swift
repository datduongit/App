//
//  NavigationController.swift
//  ami-ios-base-customer
//
//  Created by Edric D. on 2/06/2021.
//

import Foundation
import SVProgressHUD
import UIKit
import RxSwift
import RxCocoa

open class ProgressHUD: NSObject {
    
    public static let shared = ProgressHUD()
    
    public override init() {
        super.init()
        customProgressHUD()
    }
    
    private func customProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setRingThickness(1.0)
        SVProgressHUD.setMaximumDismissTimeInterval(2.0)
        SVProgressHUD.setMaxSupportedWindowLevel(UIWindow.Level.alert + 1)
    }

    public func showProgressHubOnMainThread() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }

    public func dismissProgressHubOnMainThread() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}

extension Reactive where Base: ProgressHUD {
    public var isLoading: Binder<Bool> {
        Binder(base) { base, value in
            value ? base.showProgressHubOnMainThread() : base.dismissProgressHubOnMainThread()
        }
    }
}
