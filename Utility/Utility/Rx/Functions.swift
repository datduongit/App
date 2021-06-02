//
//  Functions.swift
//  Utility
//
//  Created by Edric D. on 02/02/2021.
//

import RxSwift
import RxCocoa

public func count(from: Int, to: Int, period: TimeInterval = 30, quickStart: Bool = true) -> Observable<Int> {
    return Observable<Int>
        .timer(quickStart ? .seconds(0) : .seconds(1), period: .milliseconds(Int(period * 1000)), scheduler: MainScheduler.instance)
        .take(from - to + 1)
        .map { from - $0 }
}
