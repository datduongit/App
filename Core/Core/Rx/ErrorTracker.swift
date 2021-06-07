//
//  ErrorTracker.swift
//  Core
//
//  Created by Edric D. on 07/06/2021.
//

import RxSwift
import RxCocoa

final public class ErrorTracker: SharedSequenceConvertibleType {
    public typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<Error>()

    public func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable()
            .catchError({ [weak self] (error) -> Observable<O.Element> in
                self?._subject.onNext(error)
                return Observable.empty()
            })
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _subject.asDriverOnErrorJustComplete()
    }

    public func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }

    private func onError(_ error: Error) {
        _subject.onNext(error)
    }

    public init() {}

    deinit {
        _subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    public func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
}
