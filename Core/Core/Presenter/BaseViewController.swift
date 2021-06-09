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
    
    open var viewModel: BaseViewModel?
    
    public let disposeBag = DisposeBag()
    open var isLoading = BehaviorRelay<Bool>(value: false)
    open var error = PublishRelay<Error>()
    
    public init(viewModel: BaseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    open func setupUI() {}
    
    open func bind() {
        viewModel?.activityIndicator
            .asObservable()
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        viewModel?.errorTracker
            .asObservable()
            .bind(to: error)
            .disposed(by: disposeBag)
    }
    
}
