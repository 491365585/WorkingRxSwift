//
//  Ant+UIImage.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2017/11/23.
//

import Foundation
import CoreGraphics

typealias isSuccess = (_ isSuccess: Bool) -> Void

public class AntClassUIImage: NSObject {
    //    - (UIImage *)addImage:(NSString *)imageName1 withImage:(NSString *)imageName2 {
    //
    //    UIImage *image1 = [UIImage imageNamed:imageName1];
    //    UIImage *image2 = [UIImage imageNamed:imageName2];
    //
    //    UIGraphicsBeginImageContext(image1.size);
    //
    //    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    //
    //    [image2 drawInRect:CGRectMake((image1.size.width - image2.size.width)/2,(image1.size.height - image2.size.height)/2, image2.size.width, image2.size.height)];
    //
    //    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    //
    //    UIGraphicsEndImageContext();
    //
    //    return resultingImage;
    //    }
    
    
    var isSuccess: isSuccess?
    
    public func combineImages(_ images: [UIImage], width: CGFloat, block: ((UIImage?)->())?) {
        
        let returnWidth = width * UIScreen.main.scale
        var returnSize = CGSize.init(width: returnWidth, height: 0)
        
        for image in images {
            let height = image.size.height * returnWidth / image.size.width
            returnSize.height = returnSize.height + height
        }
        
        DispatchQueue.global().async {
            UIGraphicsBeginImageContext(returnSize)
            
            var height: CGFloat = 0
            
            for image in images {
                let subHeight = image.size.height * returnWidth / image.size.width
                image.draw(in: CGRect.init(x: 0, y: height, width: returnWidth, height: subHeight))
                height += subHeight
            }
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                if let subBlock = block {
                    subBlock(image)
                }
            }
        }
    }
    
    /// 保存图片到本地相册
    public func saveImageToPhotosAlbum(image : UIImage, block: ((_ isSuccess : Bool)->())?) {
        self.isSuccess = block
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if let e = error as NSError? {
            debugPrint("保存图片到本地相册失败:\(e)")
            if self.isSuccess != nil {
                self.isSuccess!(false)
            }
        } else {
            if self.isSuccess != nil {
                self.isSuccess!(true)
            }
        }
    }
    
}

public class AntObjectUIImage {
    
    let value: UIImage
    
    init(_ value: UIImage) {
        self.value = value
    }
    
    /// 获取缩略图
    ///
    /// - Parameter defineWidth: 缩略图的宽度
    /// - Returns: 图片
    public func thumbnail(width defineWidth: CGFloat) -> UIImage {
        
        var newImage: UIImage? = nil
        let imageSize = value.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth = defineWidth
        let targetHeight = height / (width / targetWidth)
        let size = CGSize.init(width: targetWidth, height: targetHeight)
        var scaleFactor: CGFloat = 0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint.init(x: 0, y: 0)
        
        if !imageSize.equalTo(size) {
            
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            
            if widthFactor > heightFactor {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor
            }
            
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }
                
            else if widthFactor < heightFactor {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        // MARK: 使用 drawInRect 绘图时丢失清晰度解决方法
        // MARK: http://dijkst.github.io/blog/2013/07/24/shi-yong-drawinrect-hui-tu-shi-diu-shi-qing-xi-du-jie-jue-fang-fa/
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        value.draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if let image = newImage {
            return image
        } else {
            return value
        }
    }
    
    
//    public func zipImageWithImage(size targetSize: CGSize) ->UIImage {
//        let maxFileSize = 32 * 1024
//        var compression = 0.9
//        var data : Data = UIImage.jpegData(value)(compressionQuality: CGFloat(compression)//)UIImageJPEGRepresentation(value, CGFloat(compression))!
//        while  data.count > maxFileSize{
//            compression *= 0.9
//            let image = self.zoomImageWithSize(size: targetSize)
//            data = UIImageJPEGRepresentation(image, CGFloat(compression))!
//        }
//        let image = UIImage.init(data: data)
//        return image ?? value
//    }
    
    /// 等比例缩放
    ///
    /// - Parameter targetSize: 缩略图的尺寸
    /// - Returns: 图片
    public func zoomImageWithSize(size targetSize: CGSize) -> UIImage {
        var newImage : UIImage? = nil
        let imageSize = value.size
        let width = imageSize.width
        let height = imageSize.height
        
        let targetWidth = targetSize.width
        let targetHeight = targetSize.height
        
        var scaleFactor : CGFloat = 0.0 /// 缩放比例
        var scaleWidth : CGFloat = 0.0
        var scaleHeight : CGFloat = 0.0
        
        var thumbnailPoint = CGPoint.init(x: 0.0, y: 0.0)
        if !imageSize.equalTo(targetSize) {
            let widthFactor = targetWidth / width /// 宽的比例
            let heightFactor = targetHeight / height /// 高的比例
            if widthFactor > heightFactor {
                scaleFactor = widthFactor
            }else{
                scaleFactor = heightFactor
            }
            
            ///缩放后的宽、高
            scaleWidth = width * scaleFactor
            scaleHeight = height * scaleFactor
            
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaleHeight) * 0.5
            }else if (widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaleWidth) * 0.5
            }
        }
        
        // MARK: 使用 drawInRect 绘图时丢失清晰度解决方法
        // MARK: http://dijkst.github.io/blog/2013/07/24/shi-yong-drawinrect-hui-tu-shi-diu-shi-qing-xi-du-jie-jue-fang-fa/
        /// 画布的大小
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        var thumbnailRect : CGRect = CGRect.init()
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaleWidth
        thumbnailRect.size.height = scaleHeight
        
        value.draw(in: thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        /*
        if let imageData = UIImagePNGRepresentation(newImage!) as NSData? {
            let fullPath = NSHomeDirectory().appending("/Documents/").appending("\(imageSize.width).nicholas.png")
            imageData.write(toFile: fullPath, atomically: true)
            print("fullPath=\(fullPath)")
        }
         */
        return newImage ?? value
    }
    
    
    /// 裁剪图片、截取部分图像
    ///
    /// - Parameter targetRect: 截取部分图像的尺寸
    /// - Returns: 图片
    public func cropImageWithRect(rect targetRect: CGRect) -> UIImage? {
        if let cgImage = value.cgImage, let croppedCgImage = cgImage.cropping(to: targetRect) {
            return UIImage(cgImage: croppedCgImage)
        } else if let ciImage = value.ciImage {
            let croppedCiImage = ciImage.cropped(to: targetRect)
            return UIImage(ciImage: croppedCiImage)
        }
        return nil
    }
}

extension UIImage {
    
    public static var ant: AntClassUIImage {
        return AntClassUIImage.init()
    }
    
    public var ant: AntObjectUIImage {
        return AntObjectUIImage.init(self)
    }
}
