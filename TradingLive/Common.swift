//
//  Common.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/25.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import UIKit
var homePath = ""

///整个屏幕宽度
var mainWidth: CGFloat {
    get {
        if isHorizontal {
            return CGFloat.ant.maxScreen
        }
        return CGFloat.ant.minScreen
    }
} // UIScreen.main.applicationFrame.maxX
///整个屏幕高度
var mainHeight: CGFloat {
    get {
        if isHorizontal {
            return CGFloat.ant.minScreen
        }
        return CGFloat.ant.maxScreen
    }
}// UIScreen.main.applicationFrame.maxY
//import UITableView_FDTemplateLayoutCell
