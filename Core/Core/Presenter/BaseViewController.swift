//
//  BaseViewController.swift
//  Core
//
//  Created by Edric D on 02/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseViewController<VM: BaseViewModel>: UIViewController {
    
    public let disposeBag = DisposeBag()
    
    public let viewModel: VM
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    open func bind() { }
    
}
