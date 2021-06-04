import RxSwift
import RxCocoa
import Networking
import Utility

class RemoteHomeRepo: AppBaseRepo, IHomeRepo {

    func getHomeService() -> Observable<[Home]> {
        let service = invokeService(HomeApiService.self)
        
        service.getListHomeInfo(complete: {
            let result = ListConverter(HomeDataToHome()).convert(from: $0)
            print(result)
            // hanle
        })
        return .empty()
    }
}
