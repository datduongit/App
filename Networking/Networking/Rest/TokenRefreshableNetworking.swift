//
//  TokenRefreshableNetworking.swift
//  App
//
//  Created by Robert on 11/05/2021.
//

import MoyaSugar
import RxSwift

public protocol AuthorizationServiceProtocol {
    func refreshAccessToken() -> Observable<Void>
}

private enum TokenErrorCode {
    static let expired = "access_token_expire"
    static let invalid = "authentication_fail"
}

open class TokenRefreshableNetworking<Target>: Networking<Target> where Target: SugarTargetType {
    let authService: AuthorizationServiceProtocol
    
    public init(
        authService: AuthorizationServiceProtocol,
        requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        plugins: [PluginType] = [],
        stubClosure: @escaping MoyaSugarProvider<Target>.StubClosure = MoyaSugarProvider.neverStub
    ) {
        self.authService = authService
        super.init(requestClosure: requestClosure, stubClosure: stubClosure, plugins: plugins)
    }
    
    public override func request(_ target: Target) -> Single<Response> {
        super.request(target)
            .retryWhen { [authService] errorObs in
                errorObs.flatMap { err -> Observable<Void> in
                    guard let error = err as? ResponseError else { return .error(err) }
                    let code = error.status?.code
                    switch code {
                    case TokenErrorCode.expired, TokenErrorCode.invalid:
                        return authService.refreshAccessToken()
                    default:
                        return .error(error)
                    }
                }
            }
    }
}
