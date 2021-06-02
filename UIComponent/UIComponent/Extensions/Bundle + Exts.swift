import Foundation

public extension Bundle {
    
    /// Returns the NSBundle object with which the specified class is associated. Supported for CocoaPods
    ///
    /// - Parameter anyClass: A class
    /// - Parameter targetName: A target name
    convenience init?(for anyClass: AnyClass, sdkName: String) {
        let bundle = Bundle(for: anyClass)
        
        var url = bundle.bundleURL
        if
            true == bundle.bundleIdentifier?.hasPrefix("org.cocoapods"),
            let bundleURL = bundle.url(forResource: sdkName, withExtension: "bundle") {
            url = bundleURL
        }
        self.init(url: url)
    }
}
