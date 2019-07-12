//
//  SOInfoKitManager.swift
//  SOInfoKit
//
//  Created by 马义飞 on 2018/6/9.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

public class SOInfoManager: NSObject {

    /// 单例
    public static let shared = SOInfoManager.init()
    
    /// App的主题风格 默认为.black
    public var appStyle = SOInfoAppStyle.white
    
    /// 是否是测试服务器
    public static var isTest = false
    
    //MARK: 是否是Debug版本
    public static let isDebug = false
    
    public static func setIsTest(_ isTest: Bool) {
        UserDefaults.standard.set(isTest, forKey: "DebugIsTest")
    }
    
    public static func getIsTest() -> Bool {
        return UserDefaults.standard.bool(forKey: "DebugIsTest")
    }
}



















