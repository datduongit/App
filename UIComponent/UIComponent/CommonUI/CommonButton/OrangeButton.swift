//
//  NavigationController.swift
//  ami-ios-base-customer
//
//  Created by Edric D. on 2/06/2021.
//

import UIKit

public class OrangeButton: UIButton {
    
    public var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.setTitleColor(AppColor.whiteColor, for: .normal)
        self.setTitleColor(AppColor.whiteColor, for: .normal)
        self.setTitleColor(.darkGray, for: .disabled)
        self.backgroundColor = AppColor.orangeButtonColor
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.height / 2
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.backgroundColor = self.isEnabled ? AppColor.orangeButtonColor : .lightGray
        }
    }
}
