//
//  Ant+UIFont.swift
//  AntFramework
//
//  Created by 马义飞 on 2018/6/9.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

public class AntClassUIFont: NSObject {
    
    /// 苹方-简 常规体
    @objc public func regular(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: size)!
    }
    
    /// 苹方-简 极细体
    @objc public func ultralight(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Ultralight", size: size)!
    }
    
    /// 苹方-简 细体
    @objc public func light(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Light", size: size)!
    }
    
    /// 苹方-简 纤细体
    @objc public func thin(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Thin", size: size)!
    }
    
    /// 苹方-简 中黑体
    @objc public func medium(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: size)!
//        return UIFont.init(name: "PingFangSC-Medium", size: size)!
    }
    
    /// 苹方-简 中粗体
    @objc public func semibold(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: size)!
        //return UIFont.init(name: "PingFangSC-Semibold", size: size)!
    }
}

public class AntObjectUIFont: NSObject {
    
    let value: UIFont
    
    init(_ value: UIFont) {
        self.value = value
    }
}

extension UIFont {
    
    public static var ant: AntClassUIFont {
        return AntClassUIFont.init()
    }
    
    public var ant: AntObjectUIFont {
        return AntObjectUIFont.init(self)
    }
}












