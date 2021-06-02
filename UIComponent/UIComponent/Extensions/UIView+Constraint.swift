import UIKit

extension UIView {
    public func loadViewFromNib() {
        guard let view = Bundle(for: self.classForCoder)
                .loadNibNamed(String(describing: self.classForCoder),
                              owner: self,
                              options: nil)?.first as? UIView else { return }
        self.addSubview(view)
        view.pinEdgeToSuperView()
    }
    
    public func pinEdgeToSuperView() {
        guard let superView = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            superView.topAnchor.constraint(equalTo: self.topAnchor),
            superView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            superView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            superView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
