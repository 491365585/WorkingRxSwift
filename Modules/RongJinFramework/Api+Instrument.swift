//
//  Api+Instrument.swift
//  RongJinFramework
//
//  Created by Anthony on 2018/7/3.
//  Copyright © 2018年 Anthony. All rights reserved.
//

import Foundation

// MARK: - 合约
extension Url {
    
    open class var getInstrumentList: String {
        get {
            return RongJinManager.httpHost + "/machine"
        }
    }
    
    /// instrument
    open class var instrument: String {
        get {
            
            return RongJinManager.httpHost + "/Instrument"
        }
    }
}

// MARK: - 合约
extension Api {
    
  
}



















