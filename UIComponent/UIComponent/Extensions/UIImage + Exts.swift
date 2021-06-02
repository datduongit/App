import Foundation
import UIKit

private class Resource {}

extension Bundle {
    fileprivate static let resource = Bundle(for: Resource.self, sdkName: String(describing: Resource.self))
}

extension UIImage {
    public static let defaultAvatar: UIImage? = .image(for: "default_avatar")
    public static let homeLogo: UIImage? = .image(for: "home_logo")
    public static let icBack: UIImage? = .image(for: "ic_back")
    public static let kycUpgradeImage: UIImage? = .image(for: "ic_upgrade_security")
    public static let searchImage: UIImage? = .image(for: "ic_search")
    public static let baseSuccessImage: UIImage? = .image(for: "base_success_icon")
}

extension UIImage {
    public static func getImage(name: String, aClass: AnyClass) -> UIImage {
        guard let img = UIImage(named: name, in: Bundle(for: aClass), compatibleWith: nil) else {
            return UIImage()
        }
        return img.withRenderingMode(.alwaysOriginal)
    }
    
    public convenience init?(named name: String, aClass: AnyClass) {
        self.init(named: name, in: Bundle(for: aClass), compatibleWith: nil)
    }
    
    public static func image(for name: String) -> UIImage? {
        UIImage(named: name, in: Bundle.resource, compatibleWith: nil)
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    public func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
