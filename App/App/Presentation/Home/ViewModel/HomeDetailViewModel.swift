//
//  HomeDetailViewModel.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//
import Core
import RxSwift
import RxRelay

class HomeDetailViewModel: BaseViewModel {
    
    let popToHome = PublishRelay<Void>()
}
