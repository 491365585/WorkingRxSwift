//
//  SOFont.swift
//  ShareOption
//
//  Created by 马义飞 on 2018/5/26.
//  Copyright © 2018年 马义飞. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    @objc public static var so: SOFont {
        return SOFont.init()
    }
}

public class SOFont: UIFont {
    
}

extension SOFont {
    
    @objc public class var marketFont: UIFont {
//        return UIFont.init(name: "SFUDINMittelschrift", size: 20)!
        return UIFont.init(name: "DINPro-Medium", size: 20)!
    }
    
    @objc public class func marketFont(_ size: CGFloat) -> UIFont {
//        return UIFont.init(name: "SFUDINMittelschrift", size: size)!
        return UIFont.init(name: "DINPro-Medium", size: size)!
    }
    
    @objc public class func marketFFFont(_ size: CGFloat) -> UIFont {
        //        return UIFont.init(name: "SFUDINMittelschrift", size: size)!
        return UIFont.init(name: "DINPro", size: size)!
    }
}

extension SOFont {
    
}



















