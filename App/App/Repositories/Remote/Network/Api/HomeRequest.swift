import Networking
import MoyaSugar

enum HomeRequest {
    case getHomeService
}

extension HomeRequest: AppTargetType {
    
    public var route: Route {
        switch self {
        case .getHomeService:
            return .get("home/..")
        }
    }
    
    public var parameters: Parameters? {
        return nil
    }
}
