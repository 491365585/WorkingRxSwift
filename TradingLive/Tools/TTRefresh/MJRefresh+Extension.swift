//
//  MJRefresh+Extension.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/26.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

enum TTRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}
