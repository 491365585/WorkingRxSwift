//
//  SOString.swift
//  ShareOption
//
//  Created by 马义飞 on 2018/5/18.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

extension String {
    
    public static var so: SOString {
        return SOString.init()
    }
}

//extension NSString {
//
//    @objc public static var so: SOString {
//        return SOString.init()
//    }
//}

public class SOString: NSObject {
    
}

extension SOString {
    
    @objc class public var market: String {
        return "行情"
    }
    
    @objc class public var trade: String {
        return "交易"
    }
    
    /// 行情-TitleView-Left
    @objc public class var myMarket: String {
        return "自选"
    }
    
    /// 行情-TitleView-Right
    @objc public class var allMarket: String {
        return "市场"
    }
}

extension SOString {
    @objc class public var phone : String {
        return "021-20231657"
    }
    
    @objc class public var simAccount : String {
        return "得讯模拟"
    }
    
    @objc class public var openGuideUrl : String {
        return "http://h5.91trader.com/html/freeTrade.html"
    }
}


















