//
//  UIButton+Extension.swift
//  JiuyingTrade
//
//  Created by Anthony on 2019/3/13.
//  Copyright © 2019 久盈. All rights reserved.
//

import Foundation
import UIKit

/**
 UIButton图像文字同时存在时---图像相对于文字的位置
 
 - top:    图像在上
 - left:   图像在左
 - right:  图像在右
 - bottom: 图像在下
 */
enum ZGJButtonImageEdgeInsetsStyle {
    case top, left, right, bottom
}

extension UIButton {
    func imagePosition(at style: ZGJButtonImageEdgeInsetsStyle, space: CGFloat, font: UIFont) {
        guard let imageV = imageView else { return }
        guard let titleL = titleLabel else { return }
        //获取图像的宽和高
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
        //获取文字的宽和高
        let labelWidth  = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height
        
        titleL.isUserInteractionEnabled = false
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0
        switch style {
        case .left:
            //正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .right:
            //切换位置--左文字右图像
            //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
        case .top:
            //切换位置--上图像下文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
        case .bottom:
            //切换位置--下图像上文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}




//MARK: ---runtime


extension UIScrollView {
    
    public typealias LTScrollHandle = (UIScrollView) -> Void
    
    private struct LTHandleKey {
        static var key = "glt_handle"
        static var tKey = "glt_isTableViewPlain"
    }
    
    public var scrollHandle: LTScrollHandle? {
        get { return objc_getAssociatedObject(self, &LTHandleKey.key) as? LTScrollHandle }
        set { objc_setAssociatedObject(self, &LTHandleKey.key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    @objc public var isTableViewPlain: Bool {
        get { return (objc_getAssociatedObject(self, &LTHandleKey.tKey) as? Bool) ?? false}
        set { objc_setAssociatedObject(self, &LTHandleKey.tKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
}

extension String {
    func glt_base64Decoding() -> String {
        let decodeData = NSData.init(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        if decodeData == nil || decodeData?.length == 0 {
            return "";
        }
        let decodeString = NSString(data: decodeData! as Data, encoding: String.Encoding.utf8.rawValue)
        return decodeString! as String
    }
}

extension UIScrollView {
    
    public class func initializeOnce() {
        DispatchQueue.once(token: UIDevice.current.identifierForVendor?.uuidString ?? "LTScrollView") {
            let didScroll = "X25vdGlmeURpZFNjcm9sbA==".glt_base64Decoding()
            let originSelector = Selector((didScroll))
            let swizzleSelector = #selector(glt_scrollViewDidScroll)
            glt_swizzleMethod(self, originSelector, swizzleSelector)
        }
    }
    
    @objc dynamic func glt_scrollViewDidScroll() {
        self.glt_scrollViewDidScroll()

        
        //这里添加你需要的埋点代码
//        let translatedPoint = self.panGestureRecognizer.translation(in: self)
//        if translatedPoint.y < -10 {
//            // 上滑
//            JTAudioManager.shared.audioPlayViewDown()
//        }
//        if translatedPoint.y > 10 {
//            // 下滑
//            JTAudioManager.shared.audioPlayViewShow()
//        }
        guard let scrollHandle = scrollHandle else { return }
        scrollHandle(self)
    }
}

extension NSObject {
    
    static func glt_swizzleMethod(_ cls: AnyClass?, _ originSelector: Selector, _ swizzleSelector: Selector)  {
        let originMethod = class_getInstanceMethod(cls, originSelector)
        let swizzleMethod = class_getInstanceMethod(cls, swizzleSelector)
        guard let swMethod = swizzleMethod, let oMethod = originMethod else { return }
        let didAddSuccess: Bool = class_addMethod(cls, originSelector, method_getImplementation(swMethod), method_getTypeEncoding(swMethod))
        if didAddSuccess {
            class_replaceMethod(cls, swizzleSelector, method_getImplementation(oMethod), method_getTypeEncoding(oMethod))
        } else {
            method_exchangeImplementations(oMethod, swMethod)
        }
    }
}
extension DispatchQueue {
    private static var _onceTracker = [String]()
    public class func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }

    func async(block: @escaping ()->()) {
        self.async(execute: block)
    }

    func after(time: DispatchTime, block: @escaping ()->()) {
        self.asyncAfter(deadline: time, execute: block)
    }
}
//
//public protocol SwizzlingInjection: class {
//    static func inject()
//}
//
//
//open class SwizzlingManager {
//
//    //只会调用一次的方法
//    private static let doOnce: Any? = {
//        UIScrollView.inject()
//        return nil
//    }()
//
//    open static func enableInjection() {
//        _ = SwizzlingManager.doOnce
//    }
//}
//
//
//extension UIScrollView{
//
//    open override var next: UIResponder?{
//        SwizzlingManager.enableInjection()
//        return super.next
//    }
//}
//
//
//
//extension UIScrollView: SwizzlingInjection{
//
//    public static func inject() {
//        //确保不是子类
//        guard self === UIScrollView.self else { return }
//
//        let originalSelector = #selector(setter: UIScrollView.delegate)
//        let swizzleSelector = #selector(UIScrollView.nsh_set(delegate:))
//        DispatchQueue.once(token: "com.moglo.urmoji.UIScrollView") {
//            //do swizzle method
//            AspectManager.swizzle(inClass: UIScrollView.self, swizzle: swizzleSelector, original: originalSelector)
//        }
//    }
//}
//
//struct AspectManager {
//    static func swizzle(inClass `class`: AnyClass, swizzle : Selector, original: Selector){
//
//        let originalMethod = class_getInstanceMethod(`class`, original)
//        let swizzleMethod = class_getInstanceMethod(`class`, swizzle)
//
//        let didAddMethod = class_addMethod(`class`, original, method_getImplementation(swizzleMethod!), method_getTypeEncoding(swizzleMethod!))
//
//        if didAddMethod {
//            class_replaceMethod(`class`, swizzle, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
//        } else {
//            method_exchangeImplementations(originalMethod!, swizzleMethod!)
//        }
//    }
//}
//
//extension UIScrollView {
//
//
////    fileprivate func swizzle(){
////        let originalSelector = #selector(setter: UIScrollView.delegate)
////        let swizzleSelector = #selector(UIScrollView.nsh_set(delegate:))
////        AspectManager.swizzle(inClass: self, swizzle: swizzleSelector, original: originalSelector)
////    }
//
//
//    @objc func nsh_set(delegate: UIScrollViewDelegate?){
//        nsh_set(delegate: delegate)
//
//        guard let delegate =  delegate else {return}
//        //交换cell点击事件
//
//        let originalSelector = #selector(delegate.scrollViewDidScroll(_:))
//        let swizzleSelector = #selector(UIScrollView.nsh_scrollViewDidScroll(_scrollViewDidScroll:))
//        let swizzleMethod = class_getInstanceMethod(UIScrollView.self, swizzleSelector)
//
//        let didAddMethod = class_addMethod(type(of: delegate), swizzleSelector, method_getImplementation(swizzleMethod!), method_getTypeEncoding(swizzleMethod!))
//        if didAddMethod{
//            let didSelectOriginalMethod = class_getInstanceMethod(type(of: delegate), swizzleSelector)
//            let didSelectSwizzledMethod = class_getInstanceMethod(type(of: delegate), originalSelector)
//
//            //let didSelectOriginalMethod = class_getInstanceMethod(type(of: delegate), NSSelectorFromString("nsh_scrollViewDidScroll:scrollView:"))
////            let didSelectSwizzledMethod = class_getInstanceMethod(type(of: delegate), originalSelector)
//            if didSelectSwizzledMethod == nil {
//                return
//            }
//            method_exchangeImplementations(didSelectOriginalMethod!, didSelectSwizzledMethod!)
//        }
//    }
//}
//
//
//extension UIScrollView: UIScrollViewDelegate {
//
//    @objc func nsh_scrollViewDidScroll(_scrollViewDidScroll scrollView: UIScrollView){
//        nsh_scrollViewDidScroll(_scrollViewDidScroll: scrollView)
//        //这里添加你需要的埋点代码
//        let translatedPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
//        if translatedPoint.y < 0 {
//            // 上滑
//            JTAudioManager.shared.audioPlayViewDown()
//        }
//        if translatedPoint.y > 0 {
//            // 下滑
//            JTAudioManager.shared.audioPlayViewShow()
//        }
//    }
//
//}
