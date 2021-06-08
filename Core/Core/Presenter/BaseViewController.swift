//
//  BaseViewController.swift
//  Core
//
//  Created by Edric D on 02/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseViewController: UIViewController {
    
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    open func setupUI() {}
    
    open func bind() {}
    
}
