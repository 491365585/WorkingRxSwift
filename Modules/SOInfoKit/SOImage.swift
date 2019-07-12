//
//  SOImage.swift
//  ShareOption
//
//  Created by 马义飞 on 2018/5/14.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation
import UIKit

public class SOImage: NSObject {
    
}

extension UIImage {
    
    @objc public static var so: SOImage {
        return SOImage.init()
    }
}

// MARK: - 类方法扩展
extension SOImage {
    
    @objc public var customBack: UIImage? {
        return UIImage.init(named: "customBack")
    }
    
    @objc public var marketUnCollect: UIImage? {
        return UIImage.init(named: "marketUnCollect")
    }
    
    @objc public var marketDidCollect: UIImage? {
        return UIImage.init(named: "marketDidCollect")
    }
    
    @objc public var bulletin: UIImage? {
        return UIImage.init(named: "bulletin")
    }
    
    @objc public var close: UIImage? {
        return UIImage.init(named: "close")
    }
    
    @objc public var pull: UIImage? {
        return UIImage.init(named: "pull")
    }
    
    @objc public var list: UIImage? {
        return UIImage.init(named: "list")
    }
    
    @objc public var setting: UIImage? {
        return UIImage.init(named: "setting")
    }
    
    @objc public var check: UIImage? {
        return UIImage.init(named: "check")
    }
    
    @objc public var add: UIImage? {
        return UIImage.init(named: "add")
    }
    
    @objc public var search: UIImage? {
        return UIImage.init(named: "搜索")
    }
    
    @objc public var refresh: UIImage? {
        return UIImage.init(named: "refresh")
    }
    
    @objc public var unfold: UIImage? {
        return UIImage.init(named: "unfold")
    }
    
    @objc public var moreBottom: UIImage? {
        return UIImage.init(named: "moreBottom")
    }

    @objc public var weChat: UIImage? {
        return UIImage.init(named: "weChat")
    }
    
    @objc public var loginClose: UIImage? {
        return UIImage.init(named: "loginClose")
    }
    
    @objc public var camera: UIImage? {
        return UIImage.init(named: "camera")
    }
    
    @objc public var hiddenKeyBoard: UIImage? {
        return UIImage.init(named: "hiddenKeyBoard")
    }
    
    @objc public var keyBoardBack: UIImage? {
        return UIImage.init(named: "KeyBoardBack")
    }
    
    @objc public var clear: UIImage? {
        return UIImage.init(named: "clear")
    }
    
    @objc public var limitUp: UIImage? {
        return UIImage.init(named: "limitUp")
    }
    
    @objc public var limitDown: UIImage? {
        return UIImage.init(named: "limitDown")
    }
    
    @objc public var priceLimit: UIImage? {
        return UIImage.init(named: "priceLimit")
    }
    
    @objc public var dismiss: UIImage? {
        return UIImage.init(named: "dismiss")
    }
    
    @objc public func logo(_ index: Int) -> UIImage? {
        
        var str = "\(index)"
        if str.count < 2 {
            str = "0\(str)"
        }
        
        return UIImage.init(named: "logo\(str)")
    }
}









public class InstrumentImage: NSObject {
    
    let header = "instrument"
}

extension UIImage {
    
    @objc public static var instrument: InstrumentImage {
        return InstrumentImage.init()
    }
}

// MARK: - 类方法扩展
extension InstrumentImage {
    
    @objc public func instrument(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)\(title)")
    }
    
    @objc public var unCollect: UIImage? {
        return UIImage.init(named: "\(header)UnCollect")
    }
    
    @objc public var didCollect: UIImage? {
        return UIImage.init(named: "\(header)DidCollect")
    }
    
    @objc public var write: UIImage? {
        return UIImage.init(named: "\(header)Write")
    }
    
    @objc public var shared: UIImage? {
        return UIImage.init(named: "\(header)Shared")
    }
    
    @objc public var tixing: UIImage? {
        return UIImage.init(named: "\(header)Tixing")
    }
    
    @objc public var comment: UIImage? {
        return UIImage.init(named: "\(header)Comment")
    }
    
    @objc public var list: UIImage? {
        return UIImage.init(named: "\(header)List")
    }
    
    @objc public var tixingList: UIImage? {
        return UIImage.init(named: "\(header)TixingList")
    }
    
    @objc public var delete: UIImage? {
        return UIImage.init(named: "\(header)Delete")
    }
    
    @objc public var edit: UIImage? {
        return UIImage.init(named: "\(header)Edit")
    }
    
    @objc public var search: UIImage? {
        return UIImage.init(named: "\(header)Search")
    }
    
    @objc public var zoom: UIImage? {
        return UIImage.init(named: "\(header)Zoom")
    }
}



















public class SharedImage: NSObject {
    
    let header = "shared"
}

extension UIImage {
    
    @objc public static var shared: SharedImage {
        return SharedImage.init()
    }
}

// MARK: - 类方法扩展
extension SharedImage {
    
    @objc public func shared(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)\(title)")
    }
}



















public class CompanyImage: NSObject {
    
    let header = "company"
}

extension UIImage {
    
    @objc public static var company: CompanyImage {
        return CompanyImage.init()
    }
}

// MARK: - 类方法扩展
extension CompanyImage {
    
    @objc public func company(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)\(title)")
    }
    
    @objc public func guide(_ index: Int) -> UIImage? {
        return UIImage.init(named: "\(header)Guide\(index)")
    }
    
    @objc public var bohai: UIImage? {
        return UIImage.init(named: "\(header)Bohai")
    }
    
    @objc public var shangqi: UIImage? {
        return UIImage.init(named: "\(header)Shangqi")
    }
    
    @objc public var ronghang: UIImage? {
        return UIImage.init(named: "\(header)Ronghang")
    }
    
    @objc public var fast: UIImage? {
        return UIImage.init(named: "\(header)Fast")
    }
    
    @objc public var market: UIImage? {
        return UIImage.init(named: "\(header)Market")
    }
    
    @objc public var trade: UIImage? {
        return UIImage.init(named: "\(header)Trade")
    }
    
    @objc public var cloud: UIImage? {
        return UIImage.init(named: "\(header)Cloud")
    }
    
    @objc public var idCard: UIImage? {
        return UIImage.init(named: "\(header)IDCard")
    }
    
    @objc public var bankCard: UIImage? {
        return UIImage.init(named: "\(header)BankCard")
    }
    
    @objc public var check: UIImage? {
        return UIImage.init(named: "\(header)Check")
    }
    
    @objc public var net: UIImage? {
        return UIImage.init(named: "\(header)Net")
    }
    
    @objc public var service: UIImage? {
        return UIImage.init(named: "\(header)Service")
    }
    
    @objc public var fail: UIImage? {
        return UIImage.init(named: "\(header)Fail")
    }
    
    @objc public var success: UIImage? {
        return UIImage.init(named: "\(header)Success")
    }
    
    @objc public var secureYes: UIImage? {
        return UIImage.init(named: "\(header)SecureYes")
    }
    
    @objc public var secureNo: UIImage? {
        return UIImage.init(named: "\(header)SecureNo")
    }
    
    @objc public var go: UIImage? {
        return UIImage.init(named: "\(header)Go")
    }
    
    @objc public var x: UIImage? {
        return UIImage.init(named: "\(header)X")
    }
    
    @objc public var flash: UIImage? {
        return UIImage.init(named: "\(header)Flash")
    }
    
    @objc public var unTrader: UIImage? {
        return UIImage.init(named: "\(header)UnTrader")
    }
}



















public class UserImage: NSObject {
    
    let header = "user"
}

extension UIImage {
    
    @objc public static var user: UserImage {
        return UserImage.init()
    }
}

// MARK: - 类方法扩展
extension UserImage {
    
    @objc public func user(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)\(title)")
    }
    
    @objc public func mine(_ index: Int) -> UIImage? {
        
        var str = "\(index)"
        if str.count < 2 {
            str = "0\(str)"
        }
        
        return UIImage.init(named: "userMine\(str)")
    }
    
    @objc public var helper: UIImage? {
        return UIImage.init(named: "\(header)Helper")
    }
    
    @objc public var phone: UIImage? {
        return UIImage.init(named: "\(header)Phone")
    }
    
    @objc public var server: UIImage? {
        return UIImage.init(named: "\(header)Server")
    }
    
    @objc public var onlineService: UIImage? {
        return UIImage.init(named: "\(header)OnlineService")
    }
    
    @objc public var set: UIImage? {
        return UIImage.init(named: "\(header)Set")
    }
    
    @objc public var addPhoto: UIImage? {
        return UIImage.init(named: "\(header)AddPhoto")
    }
    
    @objc public var removePhoto: UIImage? {
        return UIImage.init(named: "\(header)RemovePhoto")
    }
    
    @objc public var clear: UIImage? {
        return UIImage.init(named: "\(header)Clear")
    }
    
    @objc public var accountSelect: UIImage? {
        return UIImage.init(named: "\(header)AccountSelect")
    }
    
    @objc public var attentionAdd: UIImage? {
        return UIImage.init(named: "\(header)AttentionAdd")
    }
    
    @objc public var attentionDid: UIImage? {
        return UIImage.init(named: "\(header)AttentionDid")
    }
    
    @objc public var attentionFriend: UIImage? {
        return UIImage.init(named: "\(header)AttentionFriend")
    }
    
    @objc public var defaultAvatar: UIImage? {
        return UIImage.init(named: "\(header)DefaultAvatar")
    }
    
    @objc public var laudButton: UIImage? {
        return UIImage.init(named: "\(header)LaudButton")
    }
    
    @objc public var go: UIImage? {
        return UIImage.init(named: "\(header)Go")
    }
    
    @objc public var search: UIImage? {
        return UIImage.init(named: "\(header)Search")
    }
    
    @objc public var trouble : UIImage? {
        return UIImage.init(named: "\(header)OnlineTrouble")
    }
    
    @objc public var qCode : UIImage? {
        return UIImage.init(named: "\(header)OnlineQCode")
    }
    
    @objc public var circle : UIImage? {
        return UIImage.init(named: "\(header)OnlineCircle")
    }
    
    @objc public var savePhone : UIImage? {
        return UIImage.init(named: "\(header)OnlineSavePhone")
    }
    
    @objc public var centerPhone : UIImage? {
        return UIImage.init(named: "\(header)CenterPhone")
    }
}


// MARK: - 我的
public class MineImage: NSObject { let header = "mine" }
extension UIImage { @objc public static var mine: MineImage { return MineImage.init() } }
extension MineImage {
    
    @objc public func shared(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)\(title)")
    }
    
    @objc public func messageCenter(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)MessageCenter_\(title)")
    }
    
    @objc public var contactService: UIImage? {
        return UIImage.init(named: "\(header)ContactService")
    }
    
    @objc public var close: UIImage? {
        return UIImage.init(named: "\(header)Close")
    }
    
    @objc public var date: UIImage? {
        return UIImage.init(named: "\(header)Date")
    }
}



















public class DynamicImage: NSObject {
    
    let header = "dynamic"
}

extension UIImage {
    
    @objc public static var dynamic: DynamicImage {
        return DynamicImage.init()
    }
}

// MARK: - 类方法扩展
extension DynamicImage {
    
    @objc public func dynamic(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)\(title)")
    }
    
    @objc public var new: UIImage? {
        return UIImage.init(named: "\(header)New")
    }
    
    @objc public var newLibrary: UIImage? {
        return UIImage.init(named: "\(header)NewLibrary")
    }
    
    @objc public var newCamera: UIImage? {
        return UIImage.init(named: "\(header)NewCamera")
    }
    
    @objc public var newEmoji: UIImage? {
        return UIImage.init(named: "\(header)NewEmoji")
    }
    
    @objc public var newHidden: UIImage? {
        return UIImage.init(named: "\(header)NewHidden")
    }
    
    @objc public var attention: UIImage? {
        return UIImage.init(named: "\(header)Attention")
    }
    
    @objc public var didAttention: UIImage? {
        return UIImage.init(named: "\(header)DidAttention")
    }
    
    @objc public var shared: UIImage? {
        return UIImage.init(named: "\(header)Shared")
    }
    
    @objc public var comment: UIImage? {
        return UIImage.init(named: "\(header)Comment")
    }
    
    @objc public var praise: UIImage? {
        return UIImage.init(named: "\(header)Praise")
    }
    
    @objc public var didPraise: UIImage? {
        return UIImage.init(named: "\(header)DidPraise")
    }
    
    @objc public var sparkle: UIImage? {
        return UIImage.init(named: "\(header)Sparkle")
    }
    
    
    @objc public var more: UIImage? {
        return UIImage.init(named: "\(header)More")
    }
    
    @objc public var reason: UIImage? {
        return UIImage.init(named: "\(header)Reason")
    }
    
    @objc public var into: UIImage? {
        return UIImage.init(named: "\(header)Into")
    }
    
    @objc public var back: UIImage? {
        return UIImage.init(named: "\(header)Back")
    }
    
    @objc public var delete: UIImage? {
        return UIImage.init(named: "\(header)Delete")
    }
    
    @objc public var mask: UIImage? {
        return UIImage.init(named: "\(header)Mask")
    }
    
    @objc public var emotion: UIImage? {
        return UIImage.init(named: "\(header)Emotion")
    }
    
    @objc public var triangle: UIImage? {
        return UIImage.init(named: "\(header)Triangle")
    }
    
}




















