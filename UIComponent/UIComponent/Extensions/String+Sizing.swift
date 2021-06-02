import UIKit

extension String {
    public func width(fixHeight: CGFloat, font: UIFont?) -> CGFloat {
        guard let font = font else { return 0 }
        return (self as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                            height: fixHeight),
                                               options: .usesLineFragmentOrigin,
                                               attributes: [ .font: font ], context: nil).size.width
    }
}
