//
//  Ant+Array.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2018/1/2.
//

import UIKit

public class AntClassArray: NSObject {
    
}

public class AntObjectArray: NSObject {
    
    let value: Array<Any>
    
    init(_ value: Array<Any>) {
        self.value = value
    }
    
    public func jsonString() -> String? {
        
        guard let data = try? JSONSerialization.data(withJSONObject: self.value, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return nil
        }
        
        guard let jsonStr = String.init(data: data, encoding: String.Encoding.utf8) else {
            return nil
        }
        
        return jsonStr
    }
    
    public func jsonData() -> Data? {
        
        guard let data = try? JSONSerialization.data(withJSONObject: self.value, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return nil
        }
        
        return data
    }
}

extension Array {
    
    public static var ant: AntClassArray {
        return AntClassArray.init()
    }
    
    public var ant: AntObjectArray {
        return AntObjectArray.init(self as Array<Any>)
    }
}



















