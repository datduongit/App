import RxSwift
import RxCocoa
import Networking
import Utility

class RemoteHomeRepo: AppBaseRepo, IHomeRepo {

    func getHomeService() -> Single<[Home]> {
        
        let service = invokeService(HomeApiService.self)
        return Single<[Home]>.create { single in
            service.getListHomeInfo(complete: {
                let result = ListConverter(HomeDataToHome()).convert(from: $0)
                single(.success(result))
            })
            return Disposables.create()
        }
    }
}
