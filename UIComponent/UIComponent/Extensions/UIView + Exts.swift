import Foundation
import UIKit

extension UIView {
    public func addDashedBorder(color: UIColor, pattern: [NSNumber] = [6, 6]) {
        let layerName = "UIComponent_dash_border"
        layer.sublayers?.filter { $0.name == layerName }.forEach { $0.removeFromSuperlayer() }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = layerName
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = pattern
        shapeLayer.frame = bounds
        
        let path = CGMutablePath()
        path.addLines(between: [.zero, CGPoint(x: frame.width, y: 0)])
        
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 1.0) {
        // Add corner
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer

        // Add border
        let zPosition: CGFloat = 1000
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                guard layer.zPosition == zPosition else {
                    continue
                }

                layer.removeFromSuperlayer()
                break
            }
        }

        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = (borderColor ?? UIColor.clear).cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = self.bounds
        borderLayer.zPosition = zPosition
        self.layer.addSublayer(borderLayer)
        
    }
    
    public func roundCornersSetKey(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor?, borderWidth: CGFloat = 1.0) {
//        if self.value(forKey: "roundCornersSetKey") != nil {
//            return
//        }
//        setValue(true, forKey: "roundCornersSetKey")
        // Add corner
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        // Add border
        let zPosition: CGFloat = 1000
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                guard layer.zPosition == zPosition else {
                    continue
                }
                
                layer.removeFromSuperlayer()
                break
            }
        }
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = (borderColor ?? UIColor.clear).cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = self.bounds
        borderLayer.zPosition = zPosition
        self.layer.addSublayer(borderLayer)
        
    }
    
    public func dropShadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.backgroundColor = .clear
    }
    
    public func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    public class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIView {
    
    // MARK: - NIB
    static func nibName() -> String {
        let nameSpaceClassName = NSStringFromClass(self)
        let className = nameSpaceClassName.components(separatedBy: ".").last! as String
        return className
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.nibName(), bundle: nil)
    }
    
    public static func loadFromNib<T: UIView>() -> T {
        let nibName = "\(self)".split { $0 == "." }.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! T
    }
    
}

extension UIView {
    @IBInspectable
    open var tmnCornerRadius: CGFloat {
        set(value) {
//            self.layer.masksToBounds = true
            self.layer.cornerRadius = value
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable
    open var tmnBorderColor: UIColor? {
        set(color) {
            self.layer.borderColor = color?.cgColor
        }
        get {
            return self.layer.borderColor != nil ? UIColor(cgColor: self.layer.borderColor!) : UIColor.clear
        }
    }
    
    @IBInspectable
    open var tmnBorderWidth: CGFloat {
        set(value) {
            self.layer.borderWidth = value
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    public var statusBarFrame: CGRect {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .first { $0.isKeyWindow }
            return (window ?? keyWindow)?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        } else {
            return UIApplication.shared.statusBarFrame
        }
    }
    
    public var viewController: UIViewController? {
        var parentResponder: UIResponder? = next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

public extension UIView {
    @discardableResult
    func fromNib<T : UIView>(bundle: Bundle = .main) -> T? {
        guard let contentView = bundle.loadNibNamed(String.className(Self.self), owner: self, options: nil)?.first as? T else {
            return nil
        }
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        contentView.fillSuperview()
        return contentView
    }
    
//    func takeScreenshot(_ shouldSave: Bool = false) -> UIImage? {
//        var screenshotImage: UIImage?
//        let layer = UIApplication.shared.keyWindow!.layer
//        let scale = UIScreen.main.scale
//        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
//        guard let context = UIGraphicsGetCurrentContext() else {return nil}
//        layer.render(in: context)
//        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        if let image = screenshotImage, shouldSave {
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        }
//        return screenshotImage
//    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addSubview(_:))
    }
    
    func addSubview(_ subview: UIView...) {
        addSubviews(subview)
    }
    
    func rotate() {
        self.layer.removeAllAnimations()
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

extension CALayer {
    public func addSublayers(_ sublayers: [CALayer]) {
        sublayers.forEach(addSublayer(_:))
    }
    
    public func addSublayer(_ sublayer: CALayer...) {
        addSublayers(sublayer)
    }
}
