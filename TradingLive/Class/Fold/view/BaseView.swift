//
//  BaseView.swift
//  TradingLive
//
//  Created by Anthony on 2019/7/22.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import RongJinFramework

class BaseView: UIView {
    
    
    //MARK: 成员属性
    private var imageTopView = EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight))
    private var gradientLayer:CAGradientLayer = CAGradientLayer()
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDoubleImageViewLayer()
        
       
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: 设置图片图层的描点和 postion
    private func setupDoubleImageViewLayer(){
        
        //1添加到父控件
        
      
        
        addSubview(imageTopView)
        imageTopView.setupTop()
        
        //2.设置contents显示比例
        
        //2.1设置锚点
        /**     两张图，各显示一半，让描点为中间的FoldView样才可以用tranfrom
         
         描点就是，在将自己图层的具体坐标点，按照width  height 比例计算出x,y 显示到 position那个点上面去，整个图也就跟着动了，旋转是跟着锚点旋转的
         */
        
        
        //4 给图层增加一个阴影层
        self.gradientLayer.frame = self.imageTopView.bounds
        //4.1渐变的颜色
        self.gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        //不透明度
        self.gradientLayer.opacity = 0
        
        self.imageTopView.layer.addSublayer(self.gradientLayer)
        
        
    }
    
    
    public func anim(_ endBlock: @escaping ()->()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.imageTopView.layer.transform = CATransform3DRotate(self.imageTopView.layer.transform, CGFloat(-Double.pi), 1, 0, 0)
        }, completion: { _ in
            self.imageTopView.topBack()
        })
        UIView.animate(withDuration: 0.1, animations: {
        }, completion: { _ in
            endBlock()
            self.imageTopView.topBack()
        })
    }
    
    public func fuyuan() {
        imageTopView.layer.transform = CATransform3DIdentity
    }
    
    
    public func kAngle2Radian(_ angle: CGFloat) -> CGFloat {
        
        return CGFloat(angle / 360) * CGFloat(Double.pi)
        
    }
}


extension BaseView {
    public func getNewImage(_ foldModel: FoldModel) {
        if let image = foldModel.topImage {
            imageTopView.getPositiveImage(image)
        }
        if let backImage = foldModel.topBackImage {
            imageTopView.getBackImage(backImage)
        }
    }
}
