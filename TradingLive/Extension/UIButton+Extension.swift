//
//  UIButton+Extension.swift
//  whjz
//
//  Created by tai on 2018/7/19.
//  Copyright © 2018年 台. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(title: String,fontSize: CGFloat, color: UIColor, backImageName: String) {
        self.init()
        
        
        setBackgroundImage(UIImage(named: backImageName), for: .normal)
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    convenience init(backImageName: String) {
        self.init()
        
        contentMode = .scaleToFill

        setBackgroundImage(UIImage(named: backImageName), for: .normal)
       
    }
    
    
    convenience init(titleClose: String,titleOpen: String,fontSize: CGFloat, color: UIColor, selectedImageNameClose: String, selectedImageNameOpen:String) {
        self.init()
        
        
        setBackgroundImage(UIImage(named: selectedImageNameClose), for: .normal)
        setBackgroundImage(UIImage(named: selectedImageNameOpen), for: .selected)
        setTitle(titleClose, for: .normal)
        setTitle(titleOpen, for: .selected)
        setTitleColor(color, for: .normal)
        titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    ///角标可用,标签可用
    convenience init(numTitle: NSInteger, backColor: UIColor, fontSize: CGFloat) {
        self.init()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        backgroundColor = backColor
        setTitle("\(numTitle)",for:.normal)
        setTitleColor(UIColor.white, for: .normal)
        titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
    }
    
}
