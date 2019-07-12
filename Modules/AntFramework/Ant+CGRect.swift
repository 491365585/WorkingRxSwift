//
//  Ant+CGRect.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2017/11/23.
//

import Foundation

public class AntClassCGRect {
    
    /// 屏幕尺寸
    public var screen: CGRect {
        return CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
}

public class AntObjectCGRect {
    
    let value: CGRect
    
    init(_ value: CGRect) {
        self.value = value
    }
}

extension CGRect {
    
    public static var ant: AntClassCGRect {
        return AntClassCGRect.init()
    }
    
    public var ant: AntObjectCGRect {
        return AntObjectCGRect.init(self)
    }
}
