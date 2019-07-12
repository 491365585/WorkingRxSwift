//
//  EXUIView.swift
//  JiuyingTrade
//
//  Created by Anthony on 2018/9/21.
//  Copyright © 2018年 久盈. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public func setCardShadow() {
        
        self.layer.shadowColor = UIColor.init(white: 186/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize.init(width: 0, height: 4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }
    
    public func setTopShadow() {
        
        self.layer.shadowColor = UIColor(red: 0.67, green: 0.7, blue: 0.74, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4.5
    }
}

extension UIView {
    
    func antPositionInScreen() -> CGPoint {
        /// 先判断是否有父视图，如果没有父视图，直接返回视图的位置就行
        if let superView = self.superview {
            /**
             判断父视图是否是UIScrollView或者继承自UIScrollView
             
             先使用视图在屏幕上的位置使用视图的位置与父视图的位置X与Y分别相加
             
             如果父视图不是UIScrollView并且不继承自UIScrollView，则直接返回结果
             
             如果父视图是UIScrollView或者继承自UIScrollView
             
             还需要分别减去UIScrollView的scrollViewOffset.x和scrollViewOffset.y，然后返回结果
             */
            if let scrollView = superView as? UIScrollView {
                let position = CGPoint.init(x: self.frame.origin.x, y: self.frame.origin.y)
                let superPosition = superView.antPositionInScreen()
                let scrollViewOffset = scrollView.contentOffset
                return CGPoint.init(x: superPosition.x + position.x - scrollViewOffset.x , y: superPosition.y + position.y - scrollViewOffset.y)
            } else {
                let superPosition = superView.antPositionInScreen()
                let position = self.frame.origin
                return CGPoint.init(x: superPosition.x + position.x, y: superPosition.y + position.y)
            }
        } else {
            return self.frame.origin
        }
    }
}
