//
//  FoldModel.swift
//  RongJinFramework
//
//  Created by Anthony on 2019/7/5.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation


public struct FoldModel {
    
    fileprivate var positive: UIImage?
    fileprivate var back: UIImage?
    
    public var topImage: UIImage? {
        set {}
        get {
            if let topImage = self.positive {
                
                return getTopImage(topImage)
            }
            
            
            return nil
        }
    }
    public var bottomImage: UIImage? {
        set {}
        get {
            
            if let bottomImage = self.positive {
                
                return getBottomImage(bottomImage)
            }
            
            
            return nil
        }
    }
    public var topBackImage: UIImage? {
        set {}
        get {
            if let topBackImage = self.back {
                
                return getBackImage(getBottomImage(topBackImage))
            }
            
            
            return nil
        }
    }
    public var bottomBackImage: UIImage? {
        set {}
        get {
            if let bottomBackImage = self.back {
                
                return getBackImage(getTopImage(bottomBackImage))
            }
            
            
            return nil
        }
    }
    
    public init(_ positive: UIImage?, _ back: UIImage?) {
        self.positive = positive
        self.back = back
    }
}


extension FoldModel {
    
    fileprivate func getTopImage(_ image: UIImage) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: image.cgImage!.width, height: Int(CGFloat(image.cgImage!.height) * 0.5))
        
        let cgImageCorpped = image.cgImage?.cropping(to: rect)
        
        return UIImage(cgImage: cgImageCorpped!)
    }
    
    fileprivate func getBottomImage(_ image: UIImage) -> UIImage {
        
        let rect = CGRect(x: 0, y: Int(CGFloat(image.cgImage!.height) * 0.5), width: image.cgImage!.width, height: Int(CGFloat(image.cgImage!.height) * 0.5))
        
        let cgImageCorpped = image.cgImage?.cropping(to: rect)
        
        return UIImage(cgImage: cgImageCorpped!)
    }
    
    private func getBackImage(_ image: UIImage?) -> UIImage? {
        //原始图片
        guard let image = image else {
            return nil
        }
        //Quartz重绘图片
        let rect =  CGRect(x: 0, y: 0, width: image.size.width , height: image.size.height);//创建矩形框
        //根据size大小创建一个基于位图的图形上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 2)
        guard let currentContext =  UIGraphicsGetCurrentContext() else {
            return nil
        }//获取当前quartz 2d绘图环境
        CGContext.clip(currentContext)(to: rect)//设置当前绘图环境到矩形框
        currentContext.draw(image.cgImage!, in: rect)//绘图

//        CGContext.draw(currentContext)(image.cgImage!, in: rect)//绘图
        //翻转图片
        let drawImage =  UIGraphicsGetImageFromCurrentImageContext()//获得图片
        let flipImage =  UIImage(cgImage:drawImage!.cgImage!,
                                 scale:image.scale,
                                 orientation:image.imageOrientation  //图片方向不用改
        )
        
        return flipImage
    }
}
