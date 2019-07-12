//
//  SOColor.swift
//  ShareOption
//
//  Created by 马义飞 on 2018/5/14.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    @objc public static var so: SOColor {
        return SOColor.init()
    }
    
    internal static func soHex(_ value: NSInteger, alpha a: CGFloat = 1) -> UIColor {
        let r: CGFloat = CGFloat((value & 0xFF0000) >> 16) / CGFloat(255)
        let g: CGFloat = CGFloat((value & 0xFF00) >> 8) / CGFloat(255)
        let b: CGFloat = CGFloat((value & 0xFF)) / CGFloat(255)
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    
    
    
}

public class SOColor: UIColor {
    
}

// MARK: - 对象方法扩展
extension SOColor {
    
    /// 上涨
    public class func marketUp(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0xFF5546)
        case .white:
            return UIColor.soHex(0xec0101)
        }
    }
    @objc public class var marketUp: UIColor {
        return SOColor.marketUp(SOInfoManager.shared.appStyle)
    }
    
    /// 下跌
    public class func marketDown(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x00CC7E)
        case .white:
            return UIColor.soHex(0x009900)
        }
    }
    @objc public class var marketDown: UIColor {
        return SOColor.marketDown(SOInfoManager.shared.appStyle)
    }
    
    /// 文字 主要
    public class func marketTextMain(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0xffffff)
        case .white:
            return UIColor.soHex(0x000000)
        }
    }
    @objc public class var marketTextMain: UIColor {
        return SOColor.marketTextMain(SOInfoManager.shared.appStyle)
    }
    
    /// View的背景色 如行情页面的Cell的背景色
    public class func marketViewBackground(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x1E2024)
        case .white:
            return UIColor.soHex(0xffffff)
        }
    }
    @objc public class var marketViewBackground: UIColor {
        return SOColor.marketViewBackground(SOInfoManager.shared.appStyle)
    }
    
    /// 背景色
    public class func marketBackground(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x171717)
        case .white:
            return UIColor.soHex(0xf5f7fa)
        }
    }
    @objc public class var marketBackground: UIColor {
        return SOColor.marketBackground(SOInfoManager.shared.appStyle)
    }
    
    /// 文字 非主要
    public class func marketTextSub(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x7e829c)
        case .white:
            return UIColor.soHex(0x7e829c)
        }
    }
    @objc public class var marketTextSub: UIColor {
        return SOColor.marketTextSub(SOInfoManager.shared.appStyle)
    }
    
    /// 选择器被选中的颜色
    public class func choiceSelect(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0xFF9D1D)
        case .white:
            return UIColor.soHex(0xec0101)
        }
    }
    @objc public class var choiceSelect: UIColor {
        return SOColor.choiceSelect(SOInfoManager.shared.appStyle)
    }
    
    /// 选择器未选中的颜色
    public class func choiceUnSelect(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x8B91A1)
        case .white:
            return UIColor.soHex(0x8B91A1)
        }
    }
    @objc public class var choiceUnSelect: UIColor {
        return SOColor.choiceUnSelect(SOInfoManager.shared.appStyle)
    }
    
    /// Cell被点击选中的颜色
    public class func marketSelectCell(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x464a5b)
        case .white:
            return UIColor.soHex(0xedeef2)
        }
    }
    @objc public class var marketSelectCell: UIColor {
        return SOColor.marketSelectCell(SOInfoManager.shared.appStyle)
    }
    
    /// 交易所文字的颜色
    public class func marketExchangeText(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x20212a)
        case .white:
            return UIColor.soHex(0xffffff)
        }
    }
    @objc public class var marketExchangeText: UIColor {
        return SOColor.marketExchangeText(SOInfoManager.shared.appStyle)
    }
    
    /// 分割线的颜色
    public class func marketLine(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x515153)
        case .white:
            return UIColor.soHex(0xd8d8d8)
        }
    }
    @objc public class var marketLine: UIColor {
        return SOColor.marketLine(SOInfoManager.shared.appStyle)
    }
    
    /// K线分时线的颜色
    public class func marketTimeLine(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0xb2cdff)
        case .white:
            return UIColor.soHex(0xb2cdff)
        }
    }
    @objc public class var marketTimeLine: UIColor {
        return SOColor.marketTimeLine(SOInfoManager.shared.appStyle)
    }
    
    /// tabBar被选中的颜色
    public class func tabBarSelect(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0xffcf00)
        case .white:
            return UIColor.soHex(0x2d7cFF)//574f60
        }
    }
    @objc public class var tabBarSelect: UIColor {
        return SOColor.tabBarSelect(SOInfoManager.shared.appStyle)
    }
    
    /// tabBar没有被选中的颜色
    public class func tabBarUnSelect(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0xa1a1a1)
        case .white:
            return UIColor.soHex(0x929292)
        }
    }
    @objc public class var tabBarUnSelect: UIColor {
        return SOColor.tabBarUnSelect(SOInfoManager.shared.appStyle)
    }
    
    /// tabBar没有被选中的颜色
    public class func marketBlue(_ style: SOInfoAppStyle) -> UIColor {
        
        switch style {
        case .black:
            return UIColor.soHex(0x2086ff)
        case .white:
            return UIColor.soHex(0x2086ff)
        }
    }
    @objc public class var marketBlue: UIColor {
        return SOColor.marketBlue(SOInfoManager.shared.appStyle)
    }
}






public enum UpDownColorType {
    case up
    case down
    case zero
}


extension Double {
    
    /// tabBar没有被选中的颜色
    public func marketUpDownColor(_ zeroColor: UIColor, style: SOInfoAppStyle = SOInfoManager.shared.appStyle) -> UIColor {

        if self > 0 {
            return SOColor.marketUp(style)
        } else if self < 0 {
            return SOColor.marketDown(style)
        } else {
            return zeroColor
        }
    }
    
    public func marketUpDownColor(_ zeroColor: UIColor, style: SOInfoAppStyle = SOInfoManager.shared.appStyle, endBlock: ((UpDownColorType)->())?) -> UIColor {
        
        if self > 0 {
            endBlock?(UpDownColorType.up)
            return SOColor.marketUp(style)
        } else if self < 0 {
            endBlock?(UpDownColorType.down)
            return SOColor.marketDown(style)
        } else {
            endBlock?(UpDownColorType.zero)
            return zeroColor
        }
    }
}



















public class ForeverColor: NSObject {
    
    let header = "forever"
    
    @objc public func shared(_ title: String) -> UIImage? {
        return UIImage.init(named: "\(header)\(title)")
    }
}

extension UIColor {
    
    @objc public static var forever: ForeverColor {
        return ForeverColor.init()
    }
    
    @objc public static var 卧槽: ForeverColor {
        return ForeverColor.init()
    }
}









public class EverColor: NSObject {
    
}

extension UIColor {
    
    @objc public static var ever: EverColor {
        return EverColor.init()
    }
}

extension EverColor {
    
    @objc public var hex8b91ad: UIColor {
        return UIColor.soHex(0x8b91ad)
    }
    
    @objc public var hexfcfdff: UIColor {
        return UIColor.soHex(0xfcfdff)
    }
    
    @objc public var hex7e829c: UIColor {
        return UIColor.soHex(0x7e829c)
    }
    
    @objc public var hex3d404d: UIColor {
        return UIColor.soHex(0x3d404d)
    }
    
    @objc public var hex353744: UIColor {
        return UIColor.soHex(0x353744)
    }
    
    @objc public var hexd3d5db: UIColor {
        return UIColor.soHex(0xd3d5db)
    }
    
    @objc public var hex33353d: UIColor {
        return UIColor.soHex(0x33353d)
    }
    
    @objc public var hex50555e: UIColor {
        return UIColor.soHex(0x50555e)
    }
    
    @objc public var hex1b1d21: UIColor {
        return UIColor.soHex(0x1b1d21)
    }
    
    @objc public var hexdbdbdb: UIColor {
        return UIColor.soHex(0xdbdbdb)
    }
    
    @objc public var hex44494e: UIColor {
        return UIColor.soHex(0x44494e)
    }
    
    @objc public var hexe8e8e8: UIColor {
        return UIColor.soHex(0xe8e8e8)
    }
    
    @objc public var hex464a5b: UIColor {
        return UIColor.soHex(0x464a5b)
    }
    
    @objc public var hex574f60: UIColor {
        return UIColor.soHex(0x574f60)
    }
    
    @objc public var hexefefef: UIColor {
        return UIColor.soHex(0xefefef)
    }
    
    @objc public var hexf24a4a: UIColor {
        return UIColor.soHex(0xf24a4a)
    }
    
    @objc public var hexb5b9d3: UIColor {
        return UIColor.soHex(0xb5b9d3)
    }
    
    @objc public var hex372d43: UIColor {
        return UIColor.soHex(0x372d43)
    }
    
    @objc public var hexe2e2e2: UIColor {
        return UIColor.soHex(0xe2e2e2)
    }
    
    @objc public var hex3596fc: UIColor {
        return UIColor.soHex(0x3596fc)
    }
    
    @objc public var hex8c92ae: UIColor {
        return UIColor.soHex(0x8c92ae)
    }
    
    @objc public var hexf5f7fa: UIColor {
        return UIColor.soHex(0xf5f7fa)
    }
    
    @objc public var hexedeef2: UIColor {
        return UIColor.soHex(0xedeef2)
    }
    
    @objc public var hexd8d8d8: UIColor {
        return UIColor.soHex(0xd8d8d8)
    }
    
    @objc public var hexeaebf4: UIColor {
        return UIColor.soHex(0xeaebf4)
    }
    
    @objc public var hexff0909: UIColor {
        return UIColor.soHex(0xff0909)
    }
    
    @objc public var hexfbfbfb: UIColor {
        return UIColor.soHex(0xfbfbfb)
    }
    
    @objc public var hex323233: UIColor {
        return UIColor.soHex(0x323233)
    }
    
    @objc public var hex507daf: UIColor {
        return UIColor.soHex(0x507daf)
    }
    
    @objc public var hex979798: UIColor {
        return UIColor.soHex(0x979798)
    }
    
    @objc public var hexb8bfdf: UIColor {
        return UIColor.soHex(0xb8bfdf)
    }
    
    @objc public var hex494949: UIColor {
        return UIColor.soHex(0x494949)
    }
    
    @objc public var hex6e6e6e: UIColor {
        return UIColor.soHex(0x6e6e6e)
    }
    
    @objc public var hex3d79da: UIColor {
        return UIColor.soHex(0x3d79da)
    }
    
    @objc public var hexf6f8fa: UIColor {
        return UIColor.soHex(0xf6f8fa)
    }
    
    @objc public var hexccf0f5: UIColor {
        return UIColor.soHex(0xccf0f5)
    }
    
    @objc public var hex2e2e2e: UIColor {
        return UIColor.soHex(0x2e2e2e)
    }
    
    @objc public var hex353535: UIColor {
        return UIColor.soHex(0x353535)
    }
    
    @objc public var hex4285f4: UIColor {
        return UIColor.soHex(0x4285f4)
    }
    
    @objc public var hexdb4437: UIColor {
        return UIColor.soHex(0xdb4437)
    }
    
    @objc public var hexbbbbbb: UIColor {
        return UIColor.soHex(0xbbbbbb)
    }
    
    @objc public var hexd8ddde: UIColor {
        return UIColor.soHex(0xd8ddde)
    }
    
    @objc public var hex818182: UIColor {
        return UIColor.soHex(0x818182)
    }
    
    @objc public var hex666666: UIColor {
        return UIColor.soHex(0x666666)
    }
    
    @objc public var hexd33931: UIColor {
        return UIColor.soHex(0xd33931)
    }
    
    @objc public var hex444444: UIColor {
        return UIColor.soHex(0x444444)
    }
    
    @objc public var hexc9c8c6: UIColor {
        return UIColor.soHex(0xc9c8c6)
    }
    
    @objc public var hexa5a5a5: UIColor {
        return UIColor.soHex(0xa5a5a5)
    }
    
    @objc public var hex151515: UIColor {
        return UIColor.soHex(0x151515)
    }
    
    @objc public var hex20212a: UIColor {
        return UIColor.soHex(0x20212a)
    }
    
    @objc public var hexc6c5cd: UIColor {
        return UIColor.soHex(0xc6c5cd)
    }
    
    @objc public var hexec0101: UIColor {
        return UIColor.soHex(0xec0101)
    }
    
    @objc public var hex29293a: UIColor {
        return UIColor.soHex(0x29293a)
    }
    
    @objc public var hex8689a2: UIColor {
        return UIColor.soHex(0x8689a2)
    }
    
    @objc public var hexf29700: UIColor {
        return UIColor.soHex(0xf29700)
    }
    
    @objc public var hexe2e2e4: UIColor {
        return UIColor.soHex(0xe2e2e4)
    }
    
    @objc public var hex9999a6: UIColor {
        return UIColor.soHex(0x9999a6)
    }
    
    @objc public var hex009900: UIColor {
        return UIColor.soHex(0x009900)
    }
    
    @objc public var hex999999: UIColor {
        return UIColor.soHex(0x999999)
    }
    
    @objc public var hex4a538b: UIColor {
        return UIColor.soHex(0x4a538b)
    }
    
    @objc public var hexf2052c: UIColor {
        return UIColor.soHex(0xf2052c)
    }
    
    @objc public var hex00cc7e: UIColor {
        return UIColor.soHex(0x00cc7e)
    }
    
    @objc public var hexececec: UIColor {
        return UIColor.soHex(0xececec)
    }
    
    @objc public var hex808080: UIColor {
        return UIColor.soHex(0x808080)
    }
    
    @objc public var hexc7ccd0: UIColor {
        return UIColor.soHex(0xc7ccd0)
    }
    
    @objc public var hex7c7c7c: UIColor {
        return UIColor.soHex(0x7c7c7c)
    }
    
    @objc public var hexc4c7d4: UIColor {
        return UIColor.soHex(0xc4c7d4)
    }
    
    @objc public var hex383940: UIColor {
        return UIColor.soHex(0x383940)
    }
    
    @objc public var hexdfe3ec: UIColor {
        return UIColor.soHex(0xdfe3ec)
    }
    
    @objc public var hex0073ec: UIColor {
        return UIColor.soHex(0x0073ec)
    }
    
    @objc public var hexff2a5f: UIColor {
        return UIColor.soHex(0xff2a5f)
    }
    
    @objc public var hex004ae9: UIColor {
        return UIColor.soHex(0x004ae9)
    }
    
    @objc public var hexff3232: UIColor {
        return UIColor.soHex(0xff3232)
    }
}



















