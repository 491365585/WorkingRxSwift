//
//  SONotification.swift
//  ShareOption
//
//  Created by 马义飞 on 2018/6/4.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

public class SONotification {
    
}

extension SONotification {
    
    // MARK: 1-短信验证时间控制
    public class var authCodeTimerClick: Notification.Name {
        get {
            return NSNotification.Name(rawValue: "authCodeTimerClick")
        }
    }
    
    // MARK: 2-登陆成功
    public class var didLogin: Notification.Name {
        get {
            return NSNotification.Name(rawValue: "didLogin")
        }
    }
    
    // MARK: 3-退出登录
    public class var didLogout: Notification.Name {
        get {
            return NSNotification.Name(rawValue: "didLogout")
        }
    }
    
    // MARK: 4-App已经进入前台
    public class var didActive: Notification.Name {
        get {
            return NSNotification.Name(rawValue: "didActive")
        }
    }
    
    // MARK: 5-App已经进入后台
    public class var didBackground: Notification.Name {
        get {
            return NSNotification.Name(rawValue: "didBackground")
        }
    }
}



















