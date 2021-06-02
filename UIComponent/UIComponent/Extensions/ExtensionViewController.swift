import UIKit

public extension UIViewController {
    func addLeftMenu(_ image: UIImage, action: Selector?) {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        let tapArea: CGFloat = 20
        button.imageEdgeInsets = UIEdgeInsets(top: tapArea/2, left: 0, bottom: tapArea/2, right: tapArea)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: image.size.width + tapArea, height: image.size.height + tapArea )
        if let action = action {
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addRightMenu(_ image: UIImage, action: Selector?) {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        let tapArea: CGFloat = 20
        button.imageEdgeInsets = UIEdgeInsets(top: tapArea/2, left: 0, bottom: tapArea/2, right: 0)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: image.size.width + tapArea, height: image.size.height + tapArea )
        if let action = action {
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func removeBorderNavi() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func changeNavigationColor(_ color: UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func dismissKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //
    
    func backButtonWith(image: UIImage, title: String, font: UIFont) {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.semanticContentAttribute = .forceLeftToRight
        button.titleLabel?.font = font
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        
        let spacing: CGFloat = 10; // the amount of spacing to appear between image and title
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        button.setTitleColor(AppColor.textNavigationColor, for: .normal)
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (title as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key: Any])
        button.frame = CGRect(x: 0, y: 0, width: ceil(size.width + image.size.width + spacing), height: image.size.height)
        button.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func barButtonWith(title: String, font: UIFont, controller: UIViewController, action: Selector) {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.titleLabel?.font = font
        button.setTitle(title, for: .normal)
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.setTitleColor(AppColor.textNavigationColor, for: .normal)
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (title as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key: Any])
        button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        button.addTarget(controller, action: action, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addRightBarButtonItem(image: UIImage, title: String, font: UIFont, controller: UIViewController, action: Selector) {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.semanticContentAttribute = .forceLeftToRight
        button.titleLabel?.font = font
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        
        let spacing: CGFloat = 10; // the amount of spacing to appear between image and title
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        button.setTitleColor(AppColor.textNavigationColor, for: .normal)
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (title as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key: Any])
        button.frame = CGRect(x: 0, y: 0, width: ceil(size.width + image.size.width + spacing), height: image.size.height)
        button.addTarget(controller, action: action, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    func backAction() {
        if self.isModal {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UIViewController {
    // MARK: - Actions
    @objc func actionClose() { }
    
    @objc func actionBack() {
        navigationController?.popViewController(animated: true)
    }
}

private extension UIViewController {
    func customActivityIndicatory(_ viewContainer: UIView) -> UIActivityIndicatorView {
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = AppColor.backgroundGray.withAlphaComponent(0.72)
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .large
        } else {
            activityIndicatorView.style = .whiteLarge
        }
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        activityIndicatorView.color = AppColor.grayText
        
        viewBackgroundLoading.addSubview(activityIndicatorView)
        viewContainer.addSubview(viewBackgroundLoading)
        return activityIndicatorView
    }
}
