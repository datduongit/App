//
//  Reachability.swift
//  Networking
//
//  Created by Edric D. on 21/02/2021.
//

import Foundation
import RxSwift
import Alamofire

// An observable that completes when the app gets online (possibly completes immediately).
public func connectedToInternet() -> Single<Bool> {
    return ReachabilityManager.shared.reachObservable
        .take(1)
        .map {
            switch $0 {
            case .reachable:
                return true
            default:
                return false
            }
        }
        .asSingle()
}

private class ReachabilityManager {

    static let shared = ReachabilityManager()

    let reachObservable: Observable<NetworkReachabilityManager.NetworkReachabilityStatus>

    init() {
        reachObservable = Observable.create { subscribe in
            NetworkReachabilityManager.default?.startListening(onUpdatePerforming: subscribe.onNext)
            return Disposables.create()
        }
    }
}
