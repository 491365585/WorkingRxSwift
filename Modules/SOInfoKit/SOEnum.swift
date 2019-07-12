//
//  SOEnum.swift
//  ShareOption
//
//  Created by 马义飞 on 2018/6/1.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

/// App的主题风格
public enum SOInfoAppStyle {
    
    /// 白色主题 背景色以白色为主 状态栏为黑色
    case white
    
    /// 黑色主题 背景色以黑色为主 状态栏为白色
    case black
    
    /// 相反的状态栏的风格
    public var oppositeStatusBarStyle: UIStatusBarStyle {
        switch self {
        case .white:
            return UIStatusBarStyle.lightContent
        case .black:
            return UIStatusBarStyle.default
        }
    }
    
    /// 状态栏的风格
    public var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .white:
            return UIStatusBarStyle.default
        case .black:
            return UIStatusBarStyle.lightContent
        }
    }
}



/// 自选页面的排序方式
public enum SOMyMarketSortType {
    
    /// 按照默认的名称排序
    case name
    
    /// 按照涨幅升序
    case up
    
    /// 按照涨幅降序
    case down
}


/// 自选页面的量化数据
public enum SOMyMarketVolumeType {
    
    /// 成交
    case trade
    
    /// 持仓
    case hold
    
    /// 日增
    case add
}



















