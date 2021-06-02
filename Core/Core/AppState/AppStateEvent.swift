import RxCocoa

public enum AppState: Equatable {
    case welcome
    case login
    case main
    case logout
    case sessionExpired
}

public class AppStateEvent {
    
    public static let `default` = AppStateEvent()
    
    public let state = PublishRelay<AppState>()
    
    public static func set(state: AppState) {
        let appState = AppStateEvent.default
        appState.state.accept(state)
    }
}
