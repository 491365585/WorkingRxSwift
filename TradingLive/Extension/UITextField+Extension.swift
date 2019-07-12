//
//  UITextField+Extension.swift
//  JiuyingTrade
//
//  Created by Anthony on 2019/3/28.
//  Copyright © 2019 久盈. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    var placeholderLabel: UILabel? {
        get {
            return getIvar(name: "_placeholderLabel") as? UILabel
        }
    }
    
    //MARK:-设置暂位文字的颜色
    var placeholderColor: UIColor {
        
        get{
            
            if let label = placeholderLabel {
                let color = label.textColor
                if(color == nil){
                    return UIColor.darkWhite
                }
                return color as! UIColor
            }else {
                return UIColor.darkWhite
            }
            
        }
        
        set{
            if let label = placeholderLabel {
                label.textColor = newValue
            }
        }
        
        
    }
    
    //MARK:-设置暂位文字的字体
    var placeholderFont: UIFont{
        get{
            if let label = placeholderLabel {
                let font =  label.font
                if(font == nil){
                    return UIFont.systemFont(ofSize: 13)
                }
                return font as! UIFont
            }else {
                return UIFont.systemFont(ofSize: 13)
            }
        }
        
        
        set{
            
            if let label = placeholderLabel {
                label.font = newValue
            }
        }
        
    }
    
    
    
    convenience init(text: String) {
        self.init()
        self.placeholder = text
    }
}
