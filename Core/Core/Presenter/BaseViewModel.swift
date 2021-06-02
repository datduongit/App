//
//  BaseViewModel.swift
//  Core
//
//  Created by Edric D on 02/06/2021.
//

import RxSwift

open class BaseViewModel {
    
    public let disposeBag = DisposeBag()
    
    public init() {
        bind()
    }
    
    open func bind() {
        
    }
}
