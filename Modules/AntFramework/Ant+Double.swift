//
//  Ant+Double.swift
//  AntFramework
//
//  Created by Anthony on 2018/7/9.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

public class AntClassDouble {
    
    /// 极小值
    public var tiny: Double {
        return 0.0000001
    }
}

public class AntObjectDouble {
    
    let value: Double
    
    init(_ value: Double) {
        self.value = value
    }
    
    public func round(_ num: Int) -> Double {
        

        
        guard !self.value.isNaN else {
            return 0
        }
        
        guard !self.value.isInfinite else {
            return 0
        }
        
        if self.value == 1.7976931348623157e+308 {
            return 0
        }
        

        guard num > 0 else {
            let intValue = Int(self.value)
            return Double(intValue)
        }
        
        var number: Double = 1
        for _ in 0..<num {
            number = number * 10
        }

        if self.value.isInfinite {
            return 0
        }

        let bigValueInt = Int(self.value * number)
        let bigValueCgf = self.value * number
        
        if bigValueCgf - Double(bigValueInt) >= 0.5 {
            return Double(bigValueInt + 1) / number
        } else {
            return Double(bigValueInt) / number
        }
    }
    
    public func roundString(maxNum: Int) -> String {
        
        let returnDouble = self.round(maxNum)
        
        let returnInt = Int(returnDouble)
        
        if Double(returnInt) == returnDouble {
            return String(returnInt)
        } else {
            return String(returnDouble)
        }
    }
    
    public func roundString(staticNum: Int) -> String {
        
        let returnDouble = self.round(staticNum)
        switch staticNum {
        case 1:
            return NSString.init(format: "%.1f", returnDouble) as String
        case 2:
            return NSString.init(format: "%.2f", returnDouble) as String
        case 3:
            return NSString.init(format: "%.3f", returnDouble) as String
        case 4:
            return NSString.init(format: "%.4f", returnDouble) as String
        case 5:
            return NSString.init(format: "%.5f", returnDouble) as String
        case 6:
            return NSString.init(format: "%.6f", returnDouble) as String
        case 7:
            return NSString.init(format: "%.7f", returnDouble) as String
        case 8:
            return NSString.init(format: "%.8f", returnDouble) as String
        default:
            return NSString.init(format: "%d", Int(returnDouble)) as String
        }
    }
    
    ///给与一个double返回一个时间
    
    public func getMusicTime(progress: Double) -> String {
        if progress.isNaN {
            return "00:00"
        }
        let pro = Int(progress)
        let fen = pro / 60
        let miao = Int(pro % 60)
        
        var fenS = String(fen)
        if fen < 10 {
            fenS = "0" + String(fen)
        }
        
        var miaoS = String(miao)
        if miao < 10 {
            miaoS = "0" + String(miao)
        }
        
        return "\(fenS):\(miaoS)"
    }
    
    public func roundStringPercent(staticNum: Int) -> String {
        
        let returnDouble = self.round(staticNum)
        var returnString: String
        
        switch staticNum {
        case 1:
            returnString = NSString.init(format: "%.1f", returnDouble) as String
        case 2:
            returnString = NSString.init(format: "%.2f", returnDouble) as String
        case 3:
            returnString = NSString.init(format: "%.3f", returnDouble) as String
        case 4:
            returnString = NSString.init(format: "%.4f", returnDouble) as String
        case 5:
            returnString = NSString.init(format: "%.5f", returnDouble) as String
        case 6:
            returnString = NSString.init(format: "%.6f", returnDouble) as String
        case 7:
            returnString = NSString.init(format: "%.7f", returnDouble) as String
        case 8:
            returnString = NSString.init(format: "%.8f", returnDouble) as String
        default:
            returnString = NSString.init(format: "%.2f", returnDouble) as String
        }
        
        if !returnString.hasPrefix("-") {
            returnString = "+" + returnString
        }
        
        return returnString + "%"
    }
    
    public func roundStringAdd(maxNum: Int) -> String {
        
        let returnDouble = self.round(maxNum)
        
        let returnInt = Int(returnDouble)
        
        var returnString = ""
        
        if Double(returnInt) == returnDouble {
            returnString = String(returnInt)
        } else {
            returnString = String(returnDouble)
        }
        
        if !returnString.hasPrefix("-") {
            returnString = "+" + returnString
        }
        
        return returnString
    }
}

extension Double {
    
    public static var ant: AntClassDouble {
        return AntClassDouble.init()
    }
    
    public var ant: AntObjectDouble {
        return AntObjectDouble.init(self)
    }
}



















