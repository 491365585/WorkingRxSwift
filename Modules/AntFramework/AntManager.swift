//
//  AntManager.swift
//  AntFramework
//
//  Created by Ant on 2018/8/15.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

public class AntManager: NSObject {
    
    /// 单例
    public static let shared = AntManager.init()
}

extension AntManager {
    
    /// 是否是刘海儿屏
    public class var isBang: Bool {
        switch CGFloat.ant.maxScreen {
        case 812:
            return true
        case 896:
            return true
        default:
            return false
        }
    }
    
    /// 是否是Plus
    public class var isPlus: Bool {
        return CGFloat.ant.maxScreen == 736
    }
    
    /// 是否是SE
    public class var isSE: Bool {
        return CGFloat.ant.maxScreen == 568
    }
}



















