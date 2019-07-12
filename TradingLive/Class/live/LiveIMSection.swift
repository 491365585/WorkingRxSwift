//
//  LiveIMSection.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/26.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import NIMSDK
import RxSwift
import RxCocoa
import RxDataSources



struct LiveIMSection {
    var items: [Item]
}



extension LiveIMSection: SectionModelType {
    
    typealias Item = NIMMessage
    
    
    init(original: LiveIMSection, items: [NIMMessage]) {
        self = original
        self.items = items
    }
}
