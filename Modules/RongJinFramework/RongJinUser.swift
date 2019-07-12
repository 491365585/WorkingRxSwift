//
//  RongJinUser.swift
//  GoldenFish
//
//  Created by 马义飞 on 2018/1/1.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import UIKit
import SOInfoKit

public class RongJinUser: NSObject, NSCoding {
    
    /// 0.用户唯一id
    public var id: String = "uuid"
    
    /// 1.密码
    public var pwd: String?
    
    /// 2.token
    public var token: String?
    
    /// 3.手机号码
    public var mobile: String?
    
    /// 4.昵称
    public var nickname: String?
    
    /// 5.头像地址
    public var avatar: String?
    
    /// 6.资金账户
    public var futureAccount: String?
    
    /// 7.资金账户经纪公司ID
    public var brokerId: String?
    
    /// 8.资金账户经纪公司Name
    public var futureCompanyName: String?
    
    /// 9.微信昵称
    public var wxNickname: String?
    
    /// 10.qq昵称
    public var qqNickname: String?
    
    /// 11.sina昵称
    public var sinaNickname: String?
    
    public var profile: String?
    
    public var isV: Int? {
        guard self.isVStr != nil else {
            return 0
        }
        if isVStr == "" {
            return 0
        }else {
            return Int(isVStr ?? "0")
        }
    }
    
    public var isVStr: String? = "0"
    
    
    
    /// 12.rcToken
    public var rcToken: String?
    
    
    /// 是否已经强制登陆过一次资金账户
    public static var didMustLoginFuture = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init()
        
        if let value = aDecoder.decodeObject(forKey: "uuid") {
            if value is String {
                let valueStr = value as! String
                self.id = valueStr
            } else {
                self.id = "uuid"
            }
        } else {
            self.id = "uuid"
        }
        
        self.pwd = myAaDecoderString(coder: aDecoder, key: "pwd")
        self.token = myAaDecoderString(coder: aDecoder, key: "token")
        self.mobile = myAaDecoderString(coder: aDecoder, key: "mobile")
        
        self.nickname = myAaDecoderString(coder: aDecoder, key: "nickname")
        self.avatar = myAaDecoderString(coder: aDecoder, key: "avatar")
        self.futureAccount = myAaDecoderString(coder: aDecoder, key: "futureAccount")
        
        self.brokerId = myAaDecoderString(coder: aDecoder, key: "brokerId")
        self.futureCompanyName = myAaDecoderString(coder: aDecoder, key: "futureCompanyName")
        self.wxNickname = myAaDecoderString(coder: aDecoder, key: "wxNickname")
        self.qqNickname = myAaDecoderString(coder: aDecoder, key: "qqNickname")
        self.sinaNickname = myAaDecoderString(coder: aDecoder, key: "sinaNickname")
        self.profile = myAaDecoderString(coder: aDecoder, key: "profile")
        self.isVStr = myAaDecoderString(coder: aDecoder, key: "isV")
        self.rcToken = myAaDecoderString(coder: aDecoder, key: "rcToken")
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.id, forKey: "uuid")
        
        aCoder.encode(self.pwd, forKey: "pwd")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.mobile, forKey: "mobile")
        
        aCoder.encode(self.nickname, forKey: "nickname")
        aCoder.encode(self.avatar, forKey: "avatar")
        aCoder.encode(self.futureAccount, forKey: "futureAccount")
        
        aCoder.encode(self.brokerId, forKey: "brokerId")
        aCoder.encode(self.futureCompanyName, forKey: "futureCompanyName")
        aCoder.encode(self.wxNickname, forKey: "wxNickname")
        aCoder.encode(self.qqNickname, forKey: "qqNickname")
        aCoder.encode(self.sinaNickname, forKey: "sinaNickname")
        aCoder.encode(self.profile, forKey: "profile")
        aCoder.encode(self.isVStr, forKey: "isV")
        aCoder.encode(self.rcToken, forKey: "rcToken")
    }
    
    func myAaDecoderString(coder aDecoder: NSCoder, key: String) -> String? {
        
        if let value = aDecoder.decodeObject(forKey: key) {
            return "\(value)"
        }
        
        return nil
    }
    
    override init() {
        super.init()
    }
}

// MARK: - 类方法
extension RongJinUser {
    
//    // MARK: 保存至本地
//    class func loginContinue(_ continueBlock: (()->())?) {
//
//        if RongJinUser.user == nil {
//            JTManager.showLogin()
//        } else {
//            if let block = continueBlock {
//                block()
//            }
//        }
//    }
    
    // MARK: 获取保存地址
    class func getArchiverPath() -> (String) {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory:String = paths.first!
        let filePath = documentsDirectory.appending("/\(SOKey.userSave).data")
        return filePath
    }
    
    // MARK: 保存至本地
    public class func save(_ userModel: RongJinUser?) {
        
        if userModel  == nil {
            let data = NSMutableData.init()
            data.write(toFile: RongJinUser.getArchiverPath(), atomically: true)
        }
            
        else {
            let data = NSMutableData.init()
            let archiver = NSKeyedArchiver.init(forWritingWith: data)
            archiver.encode(userModel, forKey: SOKey.userSave)
            archiver.finishEncoding()
            data.write(toFile: RongJinUser.getArchiverPath(), atomically: true)
        }
    }
    
    // MARK: 登录
    public class func login(_ userDict: Dictionary<String, Any>) {
        
        let user = RongJinUser.init()
        
        if let id = userDict.ant.string(keys: "uuid") {
            user.id = id
        } else {
            user.id = "uuid"
        }
        
        user.pwd = userDict.ant.string(keys: "pwd")
        user.token = userDict.ant.string(keys: "token")
        user.mobile = userDict.ant.string(keys: "mobile")
        
        user.nickname = userDict.ant.string(keys: "nickname")
        user.avatar = userDict.ant.string(keys: "avatar")
        user.futureAccount = userDict.ant.string(keys: "futureAccount")
        
        user.brokerId = userDict.ant.string(keys: "brokerId")
        user.futureCompanyName = userDict.ant.string(keys: "futureCompanyName")
        user.wxNickname = userDict.ant.string(keys: "wxNickname")
        user.qqNickname = userDict.ant.string(keys: "qqNickname")
        user.sinaNickname = userDict.ant.string(keys: "sinaNickname")
        user.profile = userDict.ant.string(keys: "profile")
        user.isVStr = userDict.ant.string(keys: "isV")
        user.rcToken = userDict.ant.string(keys: "rcToken")

        RongJinUser.save(user)
        

        RongJinUser.setTokenUpdateDate()
        
        NotificationCenter.default.post(name: SONotification.didLogin, object: nil)
    }
    
    // MARK: 注销
    public class func logout() {
        
        RongJinUser.save(nil)
        
        
        NotificationCenter.default.post(name: SONotification.didLogout, object: nil)
    }
    
    public class func showUser() {
        
        guard let user = RongJinUser.user else {
            return
        }
        
        debugPrint(">")
        debugPrint(">>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        
        debugPrint("id：\(user.id)")
        
        debugPrint("pwd：\(user.pwd ?? "nil")")
        debugPrint("token：\(user.token ?? "nil")")
        debugPrint("mobile：\(user.mobile ?? "nil")")
        
        debugPrint("nickname：\(user.nickname ?? "")")
        debugPrint("avatar：\(user.avatar ?? "")")
        debugPrint("futureAccount：\(user.futureAccount ?? "")")
        
        debugPrint("brokerId：\(user.brokerId ?? "")")
        debugPrint("futureCompanyName：\(user.futureCompanyName ?? "")")
        debugPrint("wxNickname：\(user.wxNickname ?? "")")
        
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>>>>>>>>>>>")
        debugPrint(">>>>>>>>>>")
        debugPrint(">")
    }
    
    /// 刷新Token的更新时间
    public class func setTokenUpdateDate() {
        UserDefaults.standard.set(Int(Date.init().timeIntervalSince1970), forKey: "lastLoginCache")
    }
    
    /// 获取Token的更新时间
    public class func getTokenUpdateDate() -> Int {
        return UserDefaults.standard.integer(forKey: "lastLoginCache")
    }
    
    /// 获取Token的更新时间与当前时间的间隔 nil-还未进行过登录操作
    public class func getTokenUpdateDateAndNowInterval() -> Int? {
        
        let last = RongJinUser.getTokenUpdateDate()
        let current = Int(Date.init().timeIntervalSince1970)
        
        if last == 0 {
            return nil
        } else {
            return current - last
        }
    }
}

// MARK: - 类属性
extension RongJinUser {
    
    // MARK: 当前User
    public class var user: RongJinUser? {
        
        let data = NSData.init(contentsOfFile: RongJinUser.getArchiverPath())
        
        if data != nil {
            let unArchiver = NSKeyedUnarchiver.init(forReadingWith: data! as Data)
            return unArchiver.decodeObject(forKey: SOKey.userSave) as! (RongJinUser?)
        }
            
        else {
            return nil
        }
    }
    
}



















