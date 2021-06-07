//
//  BaseViewModel.swift
//  Core
//
//  Created by Edric D on 02/06/2021.
//

import RxSwift
import RxCocoa

public protocol BaseViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}

open class BaseViewModel {
    open var isLoading = PublishRelay<Bool>()
    open var error = PublishRelay<Error>()
    public let disposeBag = DisposeBag()
    
    public init() {
        bind()
    }
    
    open func bind() {}
}
