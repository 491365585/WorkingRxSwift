//
//  Api.swift
//  GoldenFish
//
//  Created by 马义飞 on 2017/12/26.
//  Copyright © 2017年 马义飞. All rights reserved.
//

import Foundation
import Alamofire
//import Alamofire
import AntFramework

public class Api {

   
    class func upload(_ url: String, parameters: [String: String], image: UIImage, index: Int = 0, successBlock: (([String: Any])->())?, failBlock: ((Error?)->())?) {
        
        var subParameters = parameters
        
        let imageData = UIImage.jpegData(image)(compressionQuality: 0.7)// UIImageJPEGRepresentation(image, 0.7)
        
        if let uuid = RongJinUser.user?.id {
            if let token = RongJinUser.user?.token {
                subParameters["uuid"] = uuid
                subParameters["token"] = (uuid + token)//.md5()
            }
            
        }
        
        subParameters["clientType"] = "1"
        let currentInt = Int(Date.init().timeIntervalSince1970)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in subParameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            if let data = imageData {
                multipartFormData.append(data, withName: "file", fileName: "\(currentInt)" + (RongJinUser.user?.id ?? "") + "\(index)" + ".jpg", mimeType: "image/jpeg")
            }
        }, to: url) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                
                upload.responseJSON(completionHandler: { (response) in
                    if let jsonData = response.result.value {
                        
                        if jsonData is Dictionary<String, Any> {
                            
                            if let block = successBlock {
                                block(jsonData as! Dictionary<String, Any>)
                            }
                        }
                            
                        else {
                            if let block = failBlock {
                                block(nil)
                            }
                        }
                    }
                        
                    else if let error = response.error {
                        if let block = failBlock {
                            block(error)
                        }
                    }
                        
                    else {
                        if let block = failBlock {
                            block(nil)
                        }
                    }
                })
                
                
            case .failure(_) :
                if let block = failBlock {
                    block(nil)
                }
            }
        }
    }
    
    static var sessionManager: Alamofire.SessionManager!

    class func request3Time(_ url: String, parameters: [String: Any], method: HTTPMethod = HTTPMethod.post, header: HTTPHeaders? = nil, successBlock: (([String: Any])->())?, failBlock: ((Error?)->())?) {
        
        var subParameters = parameters
        
        if let uuid = RongJinUser.user?.id {
            if let token = RongJinUser.user?.token {
                subParameters["uuid"] = uuid
                subParameters["token"] = (uuid + token)//.md5()
            }
        }
        
        if subParameters["clientType"] == nil {
            subParameters["clientType"] = "1"
        }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        sessionManager.request(url, method: method, parameters: subParameters, headers: header).responseJSON { (response) in
            
            if let jsonData = response.result.value {
                
                if jsonData is Dictionary<String, Any> {
                    
                    if let block = successBlock {
                        block(jsonData as! Dictionary<String, Any>)
                    }
                }
                    
                else {
                    if let block = failBlock {
                        block(nil)
                    }
                }
            }
                
            else if let error = response.error {
                if let block = failBlock {
                    block(error)
                }
            }
                
            else {
                if let block = failBlock {
                    block(nil)
                }
            }
        }
    }
    
    class public func request(_ url: String, parameters: [String: Any], method: HTTPMethod = HTTPMethod.post, header: HTTPHeaders? = nil, successBlock: (([String: Any])->())?, failBlock: ((Error?)->())?) {
        
        var subParameters = parameters
        
        if let uuid = RongJinUser.user?.id {
            if let token = RongJinUser.user?.token {
                subParameters["uuid"] = uuid
                subParameters["token"] = (uuid + token)//.md5()
            }
        }
        print("----------------------uuid" + "\(subParameters["uuid"])")
        print("----------------------token" + "\(subParameters["token"])")
        if subParameters["clientType"] == nil {
            subParameters["clientType"] = "2"
        }
                
        Alamofire.request(url, method: method, parameters: subParameters, headers: header).responseJSON { (response) in
            
            if let jsonData = response.result.value {
                
                if jsonData is Dictionary<String, Any> {
                    
                    if let block = successBlock {
                        block(jsonData as! Dictionary<String, Any>)
                    }
                }
                    
                else {
                    if let block = failBlock {
                        block(nil)
                    }
                }
            }
                
            else if let error = response.error {
                if let block = failBlock {
                    block(error)
                }
            }
                
            else {
                if let block = failBlock {
                    block(nil)
                }
            }
        }
    }
    class func requestNoUUID(_ url: String, parameters: [String: Any], method: HTTPMethod = HTTPMethod.post, header: HTTPHeaders? = nil, successBlock: (([String: Any])->())?, failBlock: ((Error?)->())?) {
        
        var subParameters = parameters
        
        if subParameters["clientType"] == nil {
            subParameters["clientType"] = "2"
        }
        
        if let uuid = RongJinUser.user?.id {
            if let token = RongJinUser.user?.token {
                subParameters["token"] = (uuid + token)//.md5()
            }
        }
        Alamofire.request(url, method: method, parameters: subParameters, headers: header).responseJSON { (response) in
            
            if let jsonData = response.result.value {
                
                if jsonData is Dictionary<String, Any> {
                    
                    if let block = successBlock {
                        block(jsonData as! Dictionary<String, Any>)
                    }
                }
                    
                else {
                    if let block = failBlock {
                        block(nil)
                    }
                }
            }
                
            else if let error = response.error {
                if let block = failBlock {
                    block(error)
                }
            }
                
            else {
                if let block = failBlock {
                    block(nil)
                }
            }
        }
    }
    
    /// 解析数据-[Any]?
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: data：[Any]? msg：提示信息
    class func dataArray(_ returnData: Dictionary<String, Any>) -> (data: [Any]?, msg: String) {
        
        let returnInfo = Api.getData(returnData, defaultData: [])
        return (returnInfo.data as? [Any], returnInfo.msg)
    }
    
    
    /// 解析数据-[String]?
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: data：[String]? msg：提示信息
    class func dataStringArray(_ returnData: Dictionary<String, Any>) -> (data: [String]?, msg: String) {
        
        let returnInfo = Api.getData(returnData, defaultData: [])
        return (returnInfo.data as? [String], returnInfo.msg)
    }
    
    
    /// 解析数据-[[String: Any]]?
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: data：[[String: Any]]? msg：提示信息
    class func dataDictArray(_ returnData: Dictionary<String, Any>) -> (data: [[String: Any]]?, msg: String) {
        
        let returnInfo = Api.getData(returnData, defaultData: [])
        return (returnInfo.data as? [[String: Any]], returnInfo.msg)
    }
    
    
    /// 解析数据-[String: Any]?
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: data：[String: Any]? msg：提示信息
    class func dataDict(_ returnData: Dictionary<String, Any>) -> (data: [String: Any]?, msg: String) {

        let returnInfo = Api.getData(returnData, defaultData: nil)
        return (returnInfo.data as? [String: Any], returnInfo.msg)
    }
    
    
    /// 解析数据-String?
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: data：String? msg：提示信息
    class func dataString(_ returnData: Dictionary<String, Any>) -> (data: String?, msg: String) {
        
        let returnInfo = Api.getData(returnData, defaultData: nil)
        return (returnInfo.data as? String, returnInfo.msg)
    }
    
    
    /// 解析数据-Bool
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: data：Bool msg：提示信息
    class func dataBool(_ returnData: Dictionary<String, Any>) -> (data: Bool, msg: String) {
        
        if let code = returnData["code"] {
            
            if code is Int {
                let codeInt = code as! Int
                if codeInt == 200 {
                    return (true, Api.getMsg(returnData))
                } else if codeInt == -100 {
                    RongJinUser.logout()
                    return (false, Api.getMsg(returnData))
                } else {
                    return (false, Api.getMsg(returnData))
                }
            }
        }
        
        return (false, Api.getMsg(returnData))
    }
    
    
    /// 获取解析数据
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: data：解析后的数据 msg：提示信息
    class func getData(_ returnData: Dictionary<String, Any>, defaultData: Any?) -> (data: Any?, msg: String) {
        
        if let code = returnData["code"] {
            
            if code is Int {
                let codeInt = code as! Int
                if codeInt == 200 {
                    if let data = returnData["data"] {
                        return (data, Api.getMsg(returnData))
                    } else {
                        return (defaultData, Api.getMsg(returnData))
                    }
                } else if codeInt == -100 {
                    RongJinUser.logout()
                    return (nil, Api.getMsg(returnData))
                } else {
                    return (nil, Api.getMsg(returnData))
                }
            }
        }
        
        return (nil, Api.getMsg(returnData))
    }
    
    
    /// 获取提示信息
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: 提示信息
    class func getMsg(_ returnData: Dictionary<String, Any>) -> String {
        
        if let msg = returnData["msg"] {
            
            if msg is String {
                let msgStr = msg as! String
                return msgStr
            }
        }
        
        return "数据错误"
    }
    
    
    /// 获取提示信息
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: 提示信息
    class func getCode(_ returnData: Dictionary<String, Any>) -> Int {
        
        if let code = returnData["code"] {
            
            if code is Int {
                let codeStr = code as! Int
                return codeStr
            }
        }
        
        return 100
    }
    /// 获取某个字段数据
    ///
    /// - Parameter returnData: 数据源
    /// - Returns: 数据
    class func getField(_ returnData: Dictionary<String, Any>, fieldStr: String) -> AnyObject? {
        
        if let data = returnData["fieldStr"] {
            
            return data as AnyObject
            
        }
        
        return nil
    }
}


// MARK: - 公开方法
extension Api {
    
    public func saveGookie() {
        
        if let cookies = HTTPCookieStorage.shared.cookies(for: URL.init(string: RongJinManager.httpHost)!) {
            var cookieArray = [[HTTPCookiePropertyKey: Any]].init()
            for cookie in cookies {
                if let properties = cookie.properties {
                    cookieArray.append(properties)
                }
            }
            UserDefaults.standard.set(cookieArray, forKey: "yfishCookie")
        }
    }
    
    public func getCookie() {
        if let cookieArray = UserDefaults.standard.array(forKey: "yfishCookie") {
            for cookieData in cookieArray {
                if let dict = cookieData as? [HTTPCookiePropertyKey: Any] {
                    if let cookie = HTTPCookie.init(properties : dict) {
                        HTTPCookieStorage.shared.setCookie(cookie)
                    }
                }
            }
        }
    }
    
    public func clearCookie() {
        
        if let cookies = HTTPCookieStorage.shared.cookies(for: URL.init(string: RongJinManager.httpHost)!) {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
            UserDefaults.standard.removeObject(forKey: "yfishCookie")
        }
    }
}



















