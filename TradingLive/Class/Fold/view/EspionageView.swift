//
//  EspionageView.swift
//  TradingLive
//
//  Created by Anthony on 2019/7/4.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation


class EspionageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate let backImage = UIImageView()
    
    fileprivate let positiveImage = UIImageView()
    
    
}


extension EspionageView {
    
    fileprivate func setupUI() {
        
        isUserInteractionEnabled = false

        setupBackImage()
        
        setupPositiveImage()
        
        
    }
    
    fileprivate func setupBackImage() {
        
        addSubview(backImage)
        backImage.frame = bounds
        backImage.contentMode = UIView.ContentMode.scaleToFill
//        backImage.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
//        backImage.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 1, 0, 0)
        

    }
    
    fileprivate func setupPositiveImage() {
        addSubview(positiveImage)
        positiveImage.frame = bounds
        positiveImage.contentMode = UIView.ContentMode.scaleToFill

    }
    
}


extension EspionageView {
    
    public func getBackImage(_ image: UIImage?) {
        backImage.image = image
    }
    
    public func getPositiveImage(_ image: UIImage?) {
        positiveImage.image = image
    }
    
    ///设置上半部
    public func setupTop() {
        
        
//        backImage.layer.contentsRect = CGRect(x: 0, y: 0.5, width: 1, height: 0.5)
        ///2.1设置锚点
        backImage.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        //3.修改图层坐标点,修改postion 其实就是center,改了之后center也跟着改了
        backImage.layer.position = CGPoint(x: backImage.center.x, y: backImage.center.y + mainHeight * 0.5)

        
        
//        positiveImage.layer.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 0.5)
        ///2.1设置锚点
        positiveImage.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        //3.修改图层坐标点,修改postion 其实就是center,改了之后center也跟着改了
        positiveImage.layer.position = CGPoint(x: positiveImage.center.x, y: positiveImage.center.y + mainHeight * 0.5)
        
        
        //3.1 虽然修改了图层的contentsRect 但是本身的高度并没有修改,导致旋转的时候,高度变高
        var frame = backImage.frame
        frame.size.height = mainHeight * 0.5
        backImage.frame = frame
        positiveImage.frame = frame
    }
    
    ///设置下半部
    public func setupBottom() {
//        backImage.layer.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 0.5)
        ///2.1设置锚点
        backImage.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        //3.2 设置底图的postion 但是不用设置实际高，因为不需要形变
        
        
        
//        positiveImage.layer.contentsRect = CGRect(x: 0, y: 0.5, width: 1, height: 0.5)
        ///2.1设置锚点
        positiveImage.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        
        //3.2 设置底图的postion 但是不用设置实际高，因为不需要形变
        var frame = backImage.frame
        frame.size.height = mainHeight * 0.5
        backImage.frame = frame
        positiveImage.frame = frame
    }
    
    public func topBack() {
        bringSubviewToFront(backImage)
    }
    
    public func topPositive() {
        bringSubviewToFront(positiveImage)
    }
    
}



extension EspionageView {
    fileprivate func radians(_ degresc: CGFloat) -> CGFloat{
        return CGFloat(degresc * 3.14159265 / 180.0)
    }
}
