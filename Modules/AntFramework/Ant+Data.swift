//
//  Ant+Data.swift
//  AntFramework
//
//  Created by Anthony on 2018/6/29.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation

public class AntClassData {
    
}

public class AntObjectData {
    
    let value: Data
    
    init(_ value: Data) {
        self.value = value
    }
    
    public func jsonDict() -> [String: Any]? {
        
        if let info = try? JSONSerialization.jsonObject(with: self.value, options: JSONSerialization.ReadingOptions.mutableContainers) {
            if info is [String: Any] {
                return info as? [String : Any]
            }
        }
        
        return nil
    }
    
    public func jsonArray() -> [Any]? {
        
        if let info = try? JSONSerialization.jsonObject(with: self.value, options: JSONSerialization.ReadingOptions.mutableContainers) {
            if info is [Any] {
                return info as? [Any]
            }
        }
        
        return nil
    }
}

extension Data {
    
    public static var ant: AntClassData {
        return AntClassData.init()
    }
    
    public var ant: AntObjectData {
        return AntObjectData.init(self)
    }
}
