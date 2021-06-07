////
////  Observable+Utils.swift
////  ami-ios-base-customer
////
////  Created by Edric D. on 22/01/2021.
////
//
//import RxSwift
//import RxCocoa
//
//public extension ObservableType where Element == Bool {
//    /// Boolean not operator
//    func not() -> Observable<Bool> {
//        return self.map(!)
//    }
//    
//}
//
//public extension SharedSequenceConvertibleType {
//    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
//        return map { _ in }
//    }
//}
//
//public extension ObservableType {
//    
//    func catchErrorJustComplete() -> Observable<Element> {
//        return catchError { _ in
//            return Observable.empty()
//        }
//    }
//    
//    func asDriverOnErrorJustComplete() -> Driver<Element> {
//        return asDriver { error in
//            return Driver.empty()
//        }
//    }
//    
//    func mapToVoid() -> Observable<Void> {
//        return map { _ in }
//    }
//}
