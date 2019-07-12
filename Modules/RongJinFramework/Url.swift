//
//  Url.swift
//  GoldenFish
//
//  Created by 马义飞 on 2017/12/26.
//  Copyright © 2017年 马义飞. All rights reserved.
//

import Foundation

public class Url {
    
}

// MARK: - 主机
extension Url {
    
    //MARK:-------------------------------------1---正式服务器
    open class var product: String {
        get {
            return "http://118.25.44.4/app/v4_0_0/"//"http://192.168.1.100:8800/v4_0_1"//
            //"http://118.25.44.4/v3_0_2"//"https://api.91trader.com/v3_0_2"//"http://192.168.1.100:8800/v3_0_2"//
        }
    }
    
    
    //MARK:-------------------------------------2---测试服务器
    open class var test: String {
        get {
            return "http://192.168.3.151:8800/v4_0_1"//"http://testapi.91trader.com/v3_0_2"//"http://118.25.44.4/v3_0_2"//"http://192.168.1.100:8800/v3_0_2"//
        }
    }
    
    //MARK:-------------------------------------3---WebSocket正式服务器
    open class var webSocketProduct: String {
        get {
            return "wss://ws.91trader.com:1024"
        }
    }
    
    //MARK:-------------------------------------4---WebSocket测试服务器
    open class var webSocketTest: String {
        get {
            return "ws://testws.91trader.com:1024"
        }
    }
}



















