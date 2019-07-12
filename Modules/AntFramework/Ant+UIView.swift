//
//  Ant+UIView.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2017/11/23.
//

import Foundation

public class AntClassUIView {
    
    let classString: String
    
    init(_ classString: String) {
        self.classString = classString
    }
    
    /// Nib
    public var nib: UINib {
        get {
            return UINib.init(nibName: classString.components(separatedBy: ".").last!, bundle: nil)
        }
    }
    
    /// Identifier
    public var identifier: String {
        get {
            return classString
        }
    }
    
    /// Identifier
    public var test: String {
        get {
            return classString
        }
    }

    /// Nib
    public func nib(_ bundleId: String) -> UINib {
        let bundle = Bundle.init(identifier: bundleId)
        return UINib.init(nibName: classString.components(separatedBy: ".").last!, bundle: bundle)
    }
    
    /// view
    public func loadNibName(nibName : String?) -> UIView {
        let loadName = nibName ?? classString.components(separatedBy: ".").last!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! UIView
    }
    
}

public class AntObjectUIView {
    
    let value: UIView
    
    init(_ value: UIView) {
        self.value = value
    }
    
    public func image(_ block: ((UIImage?) -> ())?) {
        var size = self.value.bounds.size
        size.width = size.width * UIScreen.main.scale
        size.height = size.height * UIScreen.main.scale
        let layer = self.value.layer
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            DispatchQueue.main.async {
                if image != nil {
                    if let subBlock = block {
                        subBlock(image!)
                    }
                }
            }
        }
    }
    
    public func drawImage() -> UIImage? {
        
        let rect = CGRect.init(x: 0, y: 0, width: self.value.bounds.width * UIScreen.main.scale, height: self.value.bounds.height * UIScreen.main.scale)
        UIGraphicsBeginImageContext(rect.size)
        self.value.drawHierarchy(in: rect, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
    
    //MARK: - 设置文本,并指定行间距
    
    ///设置文本,并指定行间距
    public func setText(text: String?, lineSpaing: CGFloat, wordSpaing: CGFloat, labelWidth: CGFloat = 0.0, font: UIFont = UIFont.systemFont(ofSize: 16)) {
        
        let label = self.value as! UILabel
        
        if text == nil || lineSpaing < 0.01 {
            label.text = text
            return
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpaing // 行间距
        paragraphStyle.lineBreakMode = label.lineBreakMode
        paragraphStyle.alignment = label.textAlignment
        
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSAttributedString.Key.kern : wordSpaing]) // 字间距
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text!.count))
        
        label.attributedText = attributedString
        label.sizeToFit() /// 自适应
    }
    
}

extension UIView {
    
    public static var ant: AntClassUIView {
        return AntClassUIView.init(NSStringFromClass(self))
    }
    
    public var ant: AntObjectUIView {
        return AntObjectUIView.init(self)
    }
}













