//
//  UILabel+Extension.swift
//  JiuyingTrade
//
//  Created by Anthony on 2019/5/5.
//  Copyright © 2019 久盈. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    
    
    convenience init(fontSize: CGFloat,color: UIColor) {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = color
    }
    
    convenience init(title: String, color: UIColor, fontSize: CGFloat, layoutWidth: CGFloat) {
        self.init()
        
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 0
        
        if layoutWidth > 0 {
            // 指定多行文本的换行宽度
            preferredMaxLayoutWidth = layoutWidth
            textAlignment = .left
        } else {
            textAlignment = .center
        }
        
        sizeToFit()
    }
    
    convenience init(title: String, color: UIColor, font: UIFont) {
        self.init()
        
        text = title
        textColor = color
        self.font = font
        
        
        
        sizeToFit()
    }
    
    
    
    
    
    
}
