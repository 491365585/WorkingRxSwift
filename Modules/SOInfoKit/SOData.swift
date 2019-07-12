//
//  SOData.swift
//  ShareOption
//
//  Created by 马义飞 on 2018/5/27.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

extension Data {
    
    public static var so: SOData {
        return SOData.init()
    }
}

extension NSDate {
    
    @objc public static var so: SOData {
        return SOData.init()
    }
    
//    if let data = returnString.data(using: String.Encoding.utf8) {
//        if let info = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) {
//            if info is [String: Any] {
//                self.address = GFAddress.model(info as! [String: Any])
//            }
//        }
//    }
}

public class SOData: NSObject {
    
}

extension SOData {
    
}










