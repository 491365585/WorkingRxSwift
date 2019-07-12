//
//  Ant+CGFloat.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2017/11/23.
//

/*
 
 public class AntClassCGFloat {
     
 }
 
 public class AntObjectCGFloat {
 
 let value: CGFloat
 
 init(_ value: CGFloat) {
 self.value = value
 }
 }
 
 extension CGFloat {
 
 public static var ant: AntClassCGFloat {
 return AntClassCGFloat.init()
 }
 
 public var ant: AntObjectCGFloat {
 return AntObjectCGFloat.init(self)
 }
 }
 
 */

import Foundation

public class AntClassCGFloat {
    
    /// 一个像素
    public var point: CGFloat {
        return 1.0 / UIScreen.main.scale
    }
    
    
    /// 屏幕的宽和高的最小值
    public var minScreen: CGFloat {
        if UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height {
            return UIScreen.main.bounds.size.height
        } else {
            return UIScreen.main.bounds.size.width
        }
    }
    
    
    /// 屏幕的宽和高的最大值
    public var maxScreen: CGFloat {
        if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
            return UIScreen.main.bounds.size.height
        } else {
            return UIScreen.main.bounds.size.width
        }
    }
    
    
    /// 屏幕的宽
    public var widthScreen: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    
    /// 屏幕的高
    public var heightScreen: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    
    /// 极小值
    public var tiny: CGFloat {
        return 0.0000001
    }
    
    /// 顶部导航栏高度（包括状态栏）
    public var topBar: CGFloat {
        if AntManager.isBang {
            return 44 + 44
        } else {
            return 20 + 44
        }
    }
    
    /// 顶部状态栏高度
    public var statusBar: CGFloat {
        if AntManager.isBang {
            return 44
        } else {
            return 20
        }
    }
    
    /// 底部高度
    public var bottomBar: CGFloat {
        if AntManager.isBang {
            return 49 + 34
        } else {
            return 49
        }
    }
    
    /// 底部偏移量
    public var bottomOffset: CGFloat {
        if AntManager.isBang {
            return 34
        } else {
            return 0
        }
    }
}

public class AntObjectCGFloat {
    
    let value: CGFloat
    
    init(_ value: CGFloat) {
        self.value = value
    }
    
    public func round(_ num: Int) -> CGFloat {
        
        guard num > 0 else {
            return self.value
        }
        
        var number: CGFloat = 1
        for _ in 0..<num {
            number = number * 10
        }
        
        let bigValueInt = Int(self.value * number)
        let bigValueCgf = self.value * number
        
        if bigValueCgf - CGFloat(bigValueInt) >= 0.5 {
            return CGFloat(bigValueInt + 1) / number
        } else {
            return CGFloat(bigValueInt) / number
        }
    }
}

extension CGFloat {
    
    public static var ant: AntClassCGFloat {
        return AntClassCGFloat.init()
    }
    
    public var ant: AntObjectCGFloat {
        return AntObjectCGFloat.init(self)
    }
}



















