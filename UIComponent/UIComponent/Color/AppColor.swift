//
//  AppColor.swift
//  UIComponent
//
//  Created by Dat Bui on 02/02/2021.
//

import Foundation
import UIKit

public struct AppColor {
    public static let whiteColor = UIColor.hexString(hex: "FFFFFF")
    public static let backgroundColor = UIColor.hexString(hex: "E5E5E5")
    public static let redColor = UIColor.hexString(hex: "FF4D4F")
    public static let errorTextColor = UIColor.hexString(hex: "FF4D4F")
    public static let darkGrayText = UIColor.hexString(hex: "0E162C")
    public static let grayText = darkGrayText.withAlphaComponent(0.6)
    public static let borderTextField = UIColor.hexString(hex: "1A63B6")
    public static let textNavigationColor = UIColor.hexString(hex: "0E162C")
    public static let blueLinkColor = UIColor.hexString(hex: "118DF5")
    public static let orangeButtonColor = UIColor.hexString(hex: "FF8300")
    public static let separatorColor = UIColor.hexString(hex: "DEE1E9")
    public static let hex0E162CAlpha25 = darkGrayText.withAlphaComponent(0.25)
    public static let hex0E162CAlpha60 = darkGrayText.withAlphaComponent(0.6)
    public static let hex0E162CAlpha05 = darkGrayText.withAlphaComponent(0.05)
    public static let backgroundGray = UIColor.hexString(hex: "F8F8F8")
    public static let grayTextPopup = UIColor.hexString(hex: "4B5161")
    public static let titleColor = UIColor.hexString(hex: "000000")
    public static let backgroundWhiteBlue = UIColor.hexString(hex: "FFFFFF").withAlphaComponent(0.01)
    public static let darkSeparatorColor = UIColor.hexString(hex: "FDFDFD").withAlphaComponent(0.25)
    public static let dashedColor = UIColor.hexString(hex: "BCC2D2")
    public static let hexFF4D4F = UIColor.hexString(hex: "FF4D4F")
    public static let loadingColor = UIColor.hexString(hex: "848B9A")
}
