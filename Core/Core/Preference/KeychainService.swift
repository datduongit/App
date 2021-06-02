import KeychainAccess

// MARK: - Constant Identifiers
private let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
private let service = bundleIdentifier
private let accessKeyPassword = "access.key.password"
private let accessKeyUID = "access.key.uid"

public class KeychainService: NSObject {

    public static let shared = KeychainService()
    
    private let keychain = Keychain(service: service)
    
    func savePassword(data: String, phoneNumber: String) {
        do {
            try keychain.set(data, key: accessKeyPassword + phoneNumber)
        } catch let error {
            print(error)
        }
    }
    
    func loadPassword(phoneNumber: String) -> String? {
        do {
            return try keychain.get(accessKeyPassword + phoneNumber)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func removePassword(phoneNumber: String) {
        do {
            return try keychain.remove(accessKeyPassword + phoneNumber)
        } catch let error {
            print(error)
        }
    }
    
    func saveUID(data: String) {
        do {
            try keychain.set(data, key: accessKeyUID)
        } catch let error {
            print(error)
        }
    }
    
    func loadUID() -> String? {
        do {
            return try keychain.get(accessKeyUID)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func removeUID() {
        do {
            return try keychain.remove(accessKeyUID)
        } catch let error {
            print(error)
        }
    }
    
    // MARK: - PINs
    public class func savePassword(data: String, phoneNumber: String) {
        shared.savePassword(data: data, phoneNumber: phoneNumber)
    }
    
    public class func loadPassword(phoneNumber: String) -> String? {
        return shared.loadPassword(phoneNumber: phoneNumber)
    }
    
    public class func removePassword(phoneNumber: String) {
        shared.removePassword(phoneNumber: phoneNumber)
    }

    // MARK: - UID

    public class func saveUID(data: String) {
        shared.saveUID(data: data)
    }

    public class func loadUID() -> String? {
        return shared.loadUID()
    }

    class func removeUID() {
        shared.removeUID()
    }
}
