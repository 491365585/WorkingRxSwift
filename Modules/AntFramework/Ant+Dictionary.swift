//
//  Ant+Dictionary.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2018/1/2.
//

import UIKit

public class AntClassDictionary: NSObject {
    
}

public class AntObjectDictionary: NSObject {
    
    let value: Dictionary<String, Any>
    
    init(_ value: Dictionary<String, Any>) {
        self.value = value
    }
    
    /// 解析字典，获取String类型数据
    ///
    /// - Parameters:
    ///   - keys: key
    ///   - defaultString: 默认值，不填则为nil
    /// - Returns: 返回String
    public func string(keys: String..., default defaultString: String? = nil) -> String? {
        
        var str: String? = nil
        
        if defaultString != nil {
            str = defaultString
        }
        
        for (_,key) in keys.enumerated() {
            
            if let value = self.value[key] {
                
                if value is Int {
                    str = String(value as! Int)
                }
                
                if value is String {
                    str = value as? String
                }
            }
        }
        
        if str == "" {
            str = defaultString
        }
        
        return str
    }
    
    /// 解析字典，获取Int类型数据
    ///
    /// - Parameters:
    ///   - keys: key
    ///   - defaultInt: 默认值，不填则默认为0
    /// - Returns: 返回Int
    public func int(keys: String..., default defaultInt: Int = 0) -> Int {
        
        var int: Int = defaultInt
        
        for (_,key) in keys.enumerated() {
            
            if let value = self.value[key] {

                if value is Int {
                    int = value as! Int
                }
                
                if value is String {
                    let intString: String = value as! String
                    if intString != "" {
                        int = Int(intString)!
                    }
                }
            }
        }
        
        return int
    }
    
    public func double(keys: String..., default defaultDouble: Double = 0) -> Double {
        
        var double: Double = defaultDouble
        
        for (_,key) in keys.enumerated() {
            
            if let value = self.value[key] {
                
                if value is Double {
                    double = value as! Double
                }
                
                if value is String {
                    let doubleString: String = value as! String
                    if doubleString != "" {
                        double = Double(doubleString)!
                    }
                }
            }
        }
        
        return double
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

extension Dictionary {
    
    public static var ant: AntClassDictionary {
        return AntClassDictionary.init()
    }
    
    public var ant: AntObjectDictionary {
        return AntObjectDictionary.init(self as! Dictionary<String, Any>)
    }
}



















