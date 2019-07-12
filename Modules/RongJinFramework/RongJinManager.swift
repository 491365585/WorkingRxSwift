//
//  RongJinManager.swift
//  
//
//  Created by Anthony on 2019/6/24.
//

import Foundation
//import SOInfoKit


public class RongJinManager: NSObject {
    
    /// 单例
    public static let shared = RongJinManager()
    
    /// API
    public static var api: Api {
        return Api()
    }
    
    /// URL
    public static var url: Url {
        return Url()
    }
    
    
    public static var httpHost: String {
//        if SOInfoManager.isDebug {
//            if SOInfoManager.isTest {
//                return Url.test
//            } else {
//                return Url.product
//            }
//        } else {
            return Url.product
//        }
    }
}

