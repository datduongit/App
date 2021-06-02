public class Preference {
    
    public static let `default` = Preference()
    
    private enum Keys {
        static let udidDataKey = "global.uid.data"
        static let userTokenKey = "global.user.token"
        static let userRefreshTokenKey = "global.user.refresh.token"
        static let phoneNumberKey = "aus_phone_number"
        static let useBiometricKey = "aus_use_biometric"
    }
    
    private let kvo = UserDefaults.standard
    
    public func updateDeviceUID(from uid: String) {
        kvo.set(uid, forKey: Keys.udidDataKey)
        kvo.synchronize()
    }

    public func getDeviceUID() -> String? {
        let deviceId = kvo.string(forKey: Keys.udidDataKey)
        return deviceId
    }

    public func removeDeviceUID() {
        kvo.removeObject(forKey: Keys.udidDataKey)
        kvo.synchronize()
    }
    
    public func updateUserToken(token: String?) {
        guard let token = token, token.count > 0 else {
            removeUserToken()

            return
        }

        kvo.set(token, forKey: Keys.userTokenKey)
        kvo.synchronize()
    }
    
    public func getUserToken() -> String? {
        guard let token = kvo.object(forKey: Keys.userTokenKey) as? String,
            !token.isEmpty else {
                return nil
        }

        return token
    }
    
    public func removeUserToken() {
        kvo.removeObject(forKey: Keys.userTokenKey)
        kvo.synchronize()
    }
    
    public func updateUserRefreshToken(token: String?) {
        guard let token = token, token.count > 0 else {
            removeUserRefreshToken()

            return
        }

        kvo.set(token, forKey: Keys.userRefreshTokenKey)
        kvo.synchronize()
    }
    
    public func getUserRefreshToken() -> String? {
        guard let token = kvo.object(forKey: Keys.userRefreshTokenKey) as? String,
            !token.isEmpty else {
                return nil
        }

        return token
    }
    
    public func removeUserRefreshToken() {
        kvo.removeObject(forKey: Keys.userRefreshTokenKey)
        kvo.synchronize()
    }
    
    public var phoneNumber: String? {
        set {
            kvo.setValue(newValue, forKey: Keys.phoneNumberKey)
        }
        
        get {
            return kvo.string(forKey: Keys.phoneNumberKey)
        }
    }
    
    public var useBiometric: Bool {
        set {
            kvo.setValue(newValue, forKey: Keys.useBiometricKey)
        }
        
        get {
            return kvo.bool(forKey: Keys.useBiometricKey)
        }
    }
}
