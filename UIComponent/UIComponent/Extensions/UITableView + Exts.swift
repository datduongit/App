import Foundation
import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_ aClass: T.Type, bundle: Bundle? = Bundle(for: T.self)) {
        let name = String(describing: aClass)
        if bundle?.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forCellReuseIdentifier: name)
        } else {
            register(aClass, forCellReuseIdentifier: name)
        }
    }
    
    func register<T: UITableViewHeaderFooterView>(_ aClass: T.Type, bundle: Bundle? = .main) {
        let name = String(describing: aClass)
        if bundle?.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forHeaderFooterViewReuseIdentifier: name)
        } else {
            register(aClass, forHeaderFooterViewReuseIdentifier: name)
        }
    }
    
    func dequeue<T: UITableViewCell>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }
    
    func dequeue<T: UITableViewCell>(_ aClass: T.Type, indexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name, for: indexPath) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }
    
    func cellAtIndex<T: UITableViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T? {
        return cellForRow(at: IndexPath(row: row, section: section)) as? T
    }
    
    func reloadDataWithAnimation() {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        }, completion: nil)
    }
    
    func removeBackgroundView() {
        if let labelBg = self.viewWithTag(1111) as? UILabel {
            self.backgroundView = nil
            labelBg.removeFromSuperview()
        }
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ aClass: T.Type, bundle: Bundle? = .main) {
        let name = String(describing: aClass)
        if bundle?.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: name)
        } else {
            register(aClass, forCellWithReuseIdentifier: name)
        }
    }
        
    func dequeue<T: UICollectionViewCell>(_ aClass: T.Type, _ indexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }
}
