//
//  Ant+UIColor.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2017/11/23.
//

import Foundation

public class AntClassUIColor: NSObject {
    
    /// 随机色
    public var random: UIColor {
        let r = (CGFloat(arc4random() % 256)) / CGFloat(255)
        let g = (CGFloat(arc4random() % 256)) / CGFloat(255)
        let b = (CGFloat(arc4random() % 256)) / CGFloat(255)
        let a = (CGFloat(arc4random() % 256)) / CGFloat(255)
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// 随机色
    public var randomOpacity: UIColor {
        let r = (CGFloat(arc4random() % 256)) / CGFloat(255)
        let g = (CGFloat(arc4random() % 256)) / CGFloat(255)
        let b = (CGFloat(arc4random() % 256)) / CGFloat(255)
        return UIColor.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    /// 背景色
    public var background: UIColor {
        let r = CGFloat(237) / CGFloat(255)
        let g = CGFloat(236) / CGFloat(255)
        let b = CGFloat(242) / CGFloat(255)
        return UIColor.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    /// 占位符颜色
    public var placeholder: UIColor {
        let r = CGFloat(176) / CGFloat(255)
        let g = CGFloat(175) / CGFloat(255)
        let b = CGFloat(187) / CGFloat(255)
        return UIColor.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    /// 返回十六进制颜色
    ///
    /// - Parameters:
    ///   - value: 十六进制色值
    ///   - a: 透明度
    /// - Returns: 颜色
    public func hex(_ value: NSInteger, alpha a: CGFloat = 1) -> UIColor {
        let r: CGFloat = CGFloat((value & 0xFF0000) >> 16) / CGFloat(255)
        let g: CGFloat = CGFloat((value & 0xFF00) >> 8) / CGFloat(255)
        let b: CGFloat = CGFloat((value & 0xFF)) / CGFloat(255)
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// 返回CMYK颜色
    ///
    /// - Parameters:
    ///   - c: 色值 C
    ///   - m: 色值 M
    ///   - y: 色值 Y
    ///   - k: 色值 K
    ///   - a: 透明度
    /// - Returns: 颜色
    public func cmyk(c: NSInteger, m: NSInteger, y: NSInteger, k: NSInteger, alpha a: CGFloat = 1) -> UIColor {
        let r: CGFloat = CGFloat(255 * (100 - c) * (100 - k)) / CGFloat(10000)
        let g: CGFloat = CGFloat(255 * (100 - m) * (100 - k)) / CGFloat(10000)
        let b: CGFloat = CGFloat(255 * (100 - y) * (100 - k)) / CGFloat(10000)
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// rgb
    public func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor{
        let r_ = CGFloat(r) / CGFloat(255)
        let g_ = CGFloat(g) / CGFloat(255)
        let b_ = CGFloat(b) / CGFloat(255)
        return UIColor.init(red: r_, green: g_, blue: b_, alpha: 1)
    }
}

public class AntObjectUIColor: NSObject {
    
    let value: UIColor
    
    init(_ value: UIColor) {
        self.value = value
    }
}

extension UIColor {
    
    public static var ant: AntClassUIColor {
        return AntClassUIColor.init()
    }
    
    public var ant: AntObjectUIColor {
        return AntObjectUIColor.init(self)
    }
}












