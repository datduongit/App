import RxSwift
import RxCocoa
import Networking
import Utility

class RemoteHomeRepo: AppBaseRepo, IHomeRepo {

    func getHomeService() -> Observable<[Home]> {
        
        let service = invokeService(HomeApiService.self)
        return Observable.create { obsever in
            service.getListHomeInfo(complete: {
                let result = ListConverter(HomeDataToHome()).convert(from: $0)
                obsever.onNext(result)
            })
            return Disposables.create()
        }
    }
}
