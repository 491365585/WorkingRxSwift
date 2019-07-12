//
//  SOLog.swift
//  SOInfoKit
//
//  Created by Anthony on 2018/8/10.
//  Copyright © 2018年 马义飞. All rights reserved.
//


// 不上线时用这个
//import CocoaDebug

//public class SOLog {
//
//    fileprivate static let shared = SOLog.init()
//
//    fileprivate var typeSet = Set<SOLogType>.init()
//}
//
//extension SOLog {
//
//    public class func key() -> String {
//        return "SOLogTypeKey"
//    }
//
//    public class func defaultTypeSet() -> Set<SOLogType> {
//
//        let logTypes =  [SOLogType.defaultType,
//                         SOLogType.system,
//                         SOLogType.rongJinSend,
//                         SOLogType.rongJinReceiveNormal,
//                         SOLogType.rongJinServer,
//                         SOLogType.rongHangSend,
//                         SOLogType.rongHangReceiveNormal,
//                         SOLogType.rongHangServer]
//        var typeSet = Set<SOLogType>.init()
//        for type in logTypes {
//            typeSet.insert(type)
//        }
//        return typeSet
//    }
//
//    public class func update() {
//
//        if let titles = UserDefaults.standard.object(forKey: SOLog.key()) as? [String] {
//            for title in titles {
//                if let logType = SOLogType.init(rawValue: title) {
//                    SOLog.shared.typeSet.insert(logType)
//                }
//            }
//        } else {
//            SOLog.shared.typeSet = SOLog.defaultTypeSet()
//            UserDefaults.standard.set(SOLog.shared.typeSet.map({$0.rawValue}), forKey: SOLog.key())
//        }
//
//        //CocoaDebug.enable()
//    }
//
//    public class func log<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, type: SOLogType = SOLogType.defaultType) {
//        if type.contains {
//            swiftLog(file, function, line, message, type.color)
//        }
//    }
//}




// 上线时用这个
import Foundation

public class SOLog {

    fileprivate static let shared = SOLog.init()

    fileprivate var typeSet = Set<SOLogType>.init()
}

extension SOLog {

    public class func key() -> String {
        return "SOLogTypeKey"
    }

    public class func defaultTypeSet() -> Set<SOLogType> {

        let logTypes =  [SOLogType.defaultType,
                         SOLogType.system,
                         SOLogType.rongJinSend,
                         SOLogType.rongJinReceiveNormal,
                         SOLogType.rongJinServer,
                         SOLogType.rongHangSend,
                         SOLogType.rongHangReceiveNormal,
                         SOLogType.rongHangServer]
        var typeSet = Set<SOLogType>.init()
        for type in logTypes {
            typeSet.insert(type)
        }
        return typeSet
    }

    public class func update() {

        if let titles = UserDefaults.standard.object(forKey: SOLog.key()) as? [String] {
            for title in titles {
                if let logType = SOLogType.init(rawValue: title) {
                    SOLog.shared.typeSet.insert(logType)
                }
            }
        } else {
            SOLog.shared.typeSet = SOLog.defaultTypeSet()
            UserDefaults.standard.set(SOLog.shared.typeSet.map({$0.rawValue}), forKey: SOLog.key())
        }
    }

    public class func log<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, type: SOLogType = SOLogType.defaultType) {
        if type.contains {
            debugPrint(message)
        }
    }
}





public enum SOLogType: String {
    
    case defaultType            =   "默认"
    case system                 =   "系统"
    
    
    case rongJinServer          = "融近WS Server"
    case rongJinSend            = "融近WS 发送"
    case rongJinReceiveAll      = "融近WS 接受 所有"
    case rongJinReceiveNormal   = "融近WS 接收 常用"
    case rongJinReceiveFlash    = "融近WS 接收 快讯"
    case rongJinReceiveMoney    = "融近WS 接收 资金"
    case rongJinReceiveClassify = "融近WS 接收 板块"
    
    
    case rongHangServer         = "融航WS Server"
    case rongHangSend           = "融航WS 发送"
    case rongHangReceiveNormal  = "融航WS 接收 常用"
    case rongHangReceiveKline   = "融航WS 接收 K线"
    case rongHangReceiveMarket  = "融航WS 接收 行情"
    case rongHangReceiveOther   = "融航WS 接收 其他"

    
    public var color: UIColor {
        
        switch self {
            
        case .defaultType:              return UIColor.white
        case .system:                   return UIColor.red
            
        case .rongJinServer:            return UIColor.orange
        case .rongJinSend:              return UIColor.orange
        case .rongJinReceiveAll:        return UIColor.orange
        case .rongJinReceiveNormal:     return UIColor.orange
        case .rongJinReceiveFlash:      return UIColor.orange
        case .rongJinReceiveMoney:      return UIColor.orange
        case .rongJinReceiveClassify:   return UIColor.orange
            
        case .rongHangServer:           return UIColor.purple
        case .rongHangSend:             return UIColor.purple
        case .rongHangReceiveNormal:    return UIColor.purple
        case .rongHangReceiveMarket:    return UIColor.purple
        case .rongHangReceiveKline:     return UIColor.purple
        case .rongHangReceiveOther:     return UIColor.purple
            
        }
    }
    
    public var contains: Bool {
        return SOLog.shared.typeSet.contains(self)
    }
    
    public static var all: [[SOLogType]] {
        
        let section00 = [SOLogType.system]
        
        let section01 = [SOLogType.rongJinServer,
                         SOLogType.rongJinSend,
                         SOLogType.rongJinReceiveAll,
                         SOLogType.rongJinReceiveNormal,
                         SOLogType.rongJinReceiveFlash,
                         SOLogType.rongJinReceiveMoney,
                         SOLogType.rongJinReceiveClassify]
        
        let section02 = [SOLogType.rongHangServer,
                         SOLogType.rongHangSend,
                         SOLogType.rongHangReceiveNormal,
                         SOLogType.rongHangReceiveMarket,
                         SOLogType.rongHangReceiveKline,
                         SOLogType.rongHangReceiveOther]
        
        return [section00, section01, section02]
    }
    
    public func change() {
        if self.contains {
            SOLog.shared.typeSet.remove(self)
        } else {
            SOLog.shared.typeSet.insert(self)
        }
        UserDefaults.standard.set(SOLog.shared.typeSet.map({$0.rawValue}), forKey: SOLog.key())
    }
}



















