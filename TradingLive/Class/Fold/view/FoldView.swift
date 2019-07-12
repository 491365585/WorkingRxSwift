//
//  FoldView.swift
//  TradingLive
//
//  Created by Anthony on 2019/7/4.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import RongJinFramework
import RxSwift

class FoldView: UIView {
    
    
    //MARK: 成员属性
    private var imageTopView = EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight))
    private var imageBottomView = EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight))
    private var gradientLayer:CAGradientLayer = CAGradientLayer()
    private var gradientTopLayer:CAGradientLayer = CAGradientLayer()
    
    
    public var isLast = false
    public var isNext = false
    public var lastBlock: (()->())?
    public var nextBlock: (()->())?
    public var hiddenBlock: (()->())?
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDoubleImageViewLayer()
        
//        self.rx.observe(Element.Type. , "<#T##keyPath: String##String#>")
        _ = self.rx.observe(Bool.self, "hidden")
            .subscribe(onNext: { [weak self] isHidden in
                guard let self = self else {
                    return
                }
                if isHidden ?? false {
                    
                    self.imageTopView.layer.transform = CATransform3DIdentity
                    self.imageBottomView.layer.transform = CATransform3DIdentity
                    self.gradientLayer.opacity = 0
                    self.gradientTopLayer.opacity = 0
                    if self.isLast {
                        self.lastBlock?()
                    }else if self.isNext {
                        self.nextBlock?()
                    }
                    
                    self.isLast = false
                    self.isNext = false
                    self.imageTopView.topPositive()
                    self.imageBottomView.topPositive()
                }
            })


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: 设置图片图层的描点和 postion
    private func setupDoubleImageViewLayer(){
        
        //1添加到父控件

        addSubview(imageBottomView)
        imageBottomView.setupBottom()

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
        
        self.imageBottomView.layer.addSublayer(self.gradientLayer)
        
        
        //4 给图层增加一个阴影层
        self.gradientTopLayer.frame = self.imageBottomView.bounds
        //4.1渐变的颜色
        self.gradientTopLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        //不透明度
        self.gradientTopLayer.opacity = 0
        
        self.imageTopView.layer.addSublayer(self.gradientTopLayer)
        
    }
    
    
   
    
    //MARK: 手势执行
    
    public func panFunc(_ pan: UIPanGestureRecognizer){
        if !isUserInteractionEnabled {
            return
        }
        //1.得到偏移量,就是x,y坐标与 左上角CGPointZero 的差距
        let offsetY = pan.translation(in: pan.view).y
        
        
        if offsetY < 0 {
            //下
            bringSubviewToFront(imageBottomView)
            panBottom(offsetY, pan)
            self.imageTopView.layer.transform = CATransform3DIdentity
                
            self.gradientTopLayer.opacity = 0
            
        }else {
            bringSubviewToFront(imageTopView)
            panTop(offsetY, pan)
            self.imageBottomView.layer.transform = CATransform3DIdentity
                
            self.gradientLayer.opacity = 0
            
        }
        
        //.检查用户抬起手势
        if pan.state == UIGestureRecognizer.State.ended {
            isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3, animations: {
                if self.isLast {
                    ///是上一个了
                    self.imageTopView.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(-Double.pi), 1, 0, 0)
                }else {
                    self.imageTopView.layer.transform = CATransform3DIdentity
                }
                if self.isNext {
                    ///是下一个了
                    self.imageBottomView.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(Double.pi), 1, 0, 0)
                }else {
                    self.imageBottomView.layer.transform = CATransform3DIdentity
                }
            }) { (_) in
                self.hiddenBlock?()
                UIView.animate(withDuration: 0.2, animations: {
                    
                }, completion: { (_) in
                    self.isUserInteractionEnabled = true
                })
                
                
            }
           
            
            
            

            

        }

    }
    
    
    
    fileprivate func panTop(_ y: CGFloat, _ pan: UIPanGestureRecognizer) {
        
        

        
        //2.得到旋转的角度
        let angle = -kAngle2Radian(y) * 1
        
        if CGFloat(Double.pi - 0.0001) <= -angle {
            self.imageTopView.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(-Double.pi), 1, 0, 0)
            return
        }
        
        
        isLast = CGFloat(Double.pi * 0.5) <= -angle
        if isLast {
            imageTopView.topBack()
        }else {
            imageTopView.topPositive()
        }

        //        //3.如果大于角度就固定最刚好遮盖值
        //        if abs(angle) >= kAngle2Radian(340) * 5 {
        //
        //            angle = angle / angle *  kAngle2Radian(346) * 5
        //        }
        
        //增强立体感
        var transfrom: CATransform3D = CATransform3DIdentity
        // d:人的眼睛和屏幕的垂直距离
//        let d: CGFloat = mainHeight * 2
//        // 设置形变的m34就可以增加立体感,立体感(近大远小)
//        transfrom.m34 = 0
        
        //2.根据 y 值的大小进行旋转X轴的角度
        transfrom = CATransform3DRotate(transfrom, angle, 1, 0, 0)
//        print(angle)
        
        self.imageTopView.layer.transform = transfrom
        
        //2.1设置阴影
        print(Float(abs(angle) / kAngle2Radian(100)))
        self.gradientLayer.opacity = Float(abs(angle) / kAngle2Radian(100))
        

    }
    
    fileprivate func panBottom(_ y: CGFloat, _ pan: UIPanGestureRecognizer) {
        
        

        
        //2.得到旋转的角度
        let angle = -kAngle2Radian(y) * 1
        
        
        if CGFloat(Double.pi - 0.0001) <= angle {
            self.imageBottomView.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(Double.pi), 1, 0, 0)
            return
        }

        isNext = CGFloat(Double.pi * 0.5) <= angle
        if isNext {
            imageBottomView.topBack()
        }else {
            imageBottomView.topPositive()
        }
        //增强立体感
        var transfrom:CATransform3D = CATransform3DIdentity
        // d:人的眼睛和屏幕的垂直距离
//        let d: CGFloat = mainHeight * 2
//         设置形变的m34就可以增加立体感,立体感(近大远小)
//        transfrom.m34 =  0
        
        //2.根据 y 值的大小进行旋转X轴的角度
        transfrom = CATransform3DRotate(transfrom, angle, 1, 0, 0)
        
        
        self.imageBottomView.layer.transform = transfrom
        
        //2.1设置阴影
        self.gradientTopLayer.opacity = Float(abs(angle) / kAngle2Radian(100))
        

    }
    
    public func kAngle2Radian(_ angle: CGFloat) -> CGFloat {
        
        return CGFloat(angle / 360) * CGFloat(Double.pi)
        
    }
}


extension FoldView {
    public func getNewImage(_ foldModel: FoldModel) {
        if let image = foldModel.topImage {
            imageTopView.getPositiveImage(image)
        }
        if let image = foldModel.bottomImage {
            imageBottomView.getPositiveImage(image)
        }
        if let backImage = foldModel.topBackImage {
            imageTopView.getBackImage(backImage)
        }
        if let backImage = foldModel.bottomBackImage {
            imageBottomView.getBackImage(backImage)
        }
    }
}
