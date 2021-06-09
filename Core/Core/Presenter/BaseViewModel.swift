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
    public let disposeBag = DisposeBag()
    
    open var activityIndicator = ActivityIndicator()
    open var errorTracker = ErrorTracker()
    
    public init() {
        bind()
    }
    
    open func bind() {
    }
}
