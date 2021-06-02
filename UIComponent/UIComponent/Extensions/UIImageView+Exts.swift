import Nuke

extension UIImageView {
    private enum Keys {
        static var loadingID = "loading_id_key"
    }
    
    public func loadImage(with source: ImageRequestConvertible?, options: ImageLoadingOptions = .shared, progress: ImageTask.ProgressHandler? = nil, completion: ImageTask.Completion? = nil) {
        guard let source = source else {
            if let placeHolder = options.placeholder {
                let id = UUID().uuidString
                self.loadingID = id
                DispatchQueue.main.async { [weak self] in
                    if let self = self, id == self.loadingID {
                        self.image = placeHolder
                    }
                }
            }
            return
        }
        Nuke.loadImage(with: source, options: options, into: self, progress: progress, completion: completion)
    }
    
    private var loadingID: String? {
        get { objc_getAssociatedObject(self, &Keys.loadingID) as? String }
        set { objc_setAssociatedObject(self, &Keys.loadingID, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
