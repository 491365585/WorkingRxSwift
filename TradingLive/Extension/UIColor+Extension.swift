//
//  UIColor+Extension.swift
//  whjz
//
//  Created by tai on 2018/6/28.
//  Copyright © 2018年 台. All rights reserved.
//

import Foundation
import UIKit


//MARK: --iOS13所需要用到的基础颜色主题
extension UIColor {
    
    ///iOS13-白色
    class var darkWhite: UIColor {
        return hexColor("#FFFFFF", dark: "#000000")
    }
    
    ///iOS13-白色-> 暗黑模式下淡黑色
    class var darkGrayWhite: UIColor {
        return hexColor("#FFFFFF", dark: "#1C1C1E")
    }
    
    ///iOS13-黑色
    class var darkBlack: UIColor {
        return hexColor("#000000", dark: "#FFFFFF")
    }
    
}

extension UIColor {

    class func hexFixedColor(_ hexString: String) -> UIColor {
        return hex(hexString)
    }
    class func hexColor(_ hexString: String, dark darkHexString: String = "") -> UIColor {
        ///获得当前hexString的暗黑模式代码
//        let darkString = darkHexString == "" ? "#FFFFFF" : darkHexString
//
//
//        if #available(iOS 13.0, *) {
//            return UIColor {(traitCollection) -> UIColor in
//
//                switch traitCollection.userInterfaceStyle {
//                case .light:
//                    return UIColor.hex(hexString)
//                case .dark:
//                    return UIColor.hex(darkString)
//                default:
//                    return UIColor.hex(hexString)
//                    //                    fatalError()
//                }
//            }
//        } else {
//            // Fallback on earlier versions
            return hex(hexString)
//        }
        
    }
    
    
    fileprivate class func hex(_ hexString: String) -> UIColor {
        
        var cString = hexString.trimmingCharacters(in:.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            //            cString = cString[(from: cString.index(after: cString.startIndex))
            cString = String(cString[cString.index(after: cString.startIndex)..<cString.endIndex])
            
        }
        if (cString.count != 6) {
            return UIColor.clear
        }
        //        let rString = cString.substring(to: cString.index(cString.startIndex, offsetBy: 2))
        let rString = cString[..<cString.index(cString.startIndex, offsetBy: 2)]
        //        let gString = cString.substring(with: cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.startIndex, offsetBy: 4))
        let gString = cString[cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.startIndex, offsetBy: 4)]
        
        //        let bString = cString.substring(from: cString.index(cString.endIndex, offsetBy: -2))
        let bString = cString[cString.index(cString.endIndex, offsetBy: -2)..<cString.endIndex]
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: String(rString)).scanHexInt32(&r)
        Scanner(string: String(gString)).scanHexInt32(&g)
        Scanner(string: String(bString)).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
      
    }
    
}

