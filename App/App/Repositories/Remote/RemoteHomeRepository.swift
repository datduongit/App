import RxSwift
import RxCocoa
import Core
import Utility

//class RemoteHomeRepository: HomeRepository {
//
//    private let service: HomeService
//
//    init(service: HomeService) {
//        self.service = service
//    }
//
//    func getHomeService() -> Observable<[HomeModel]> {
//        return service.provider.request(.getHomeService)
//            .map([HomeModel].self, atKeyPath: "data")
//            .catchErrorJustReturn([])
//            .asObservable()
//    }
//}
