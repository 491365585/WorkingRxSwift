//
//  SOLimit.swift
//  GoldenFish
//
//  Created by 马义飞 on 2017/12/28.
//  Copyright © 2017年 马义飞. All rights reserved.
//

import Photos
import AVKit

class SOLimit {
    
}

extension SOLimit {
    
    //MARK:-------------------------------------1-是否可以访问相册
    open class var library: Bool {
        get {
            let status = PHPhotoLibrary.authorizationStatus()
            if status == PHAuthorizationStatus.denied || status == PHAuthorizationStatus.restricted {
                return false
            } else {
                return true
            }
        }
    }
    
    //MARK:-------------------------------------2-是否可以访问相机
    open class var camera: Bool {
        get {
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            if status == AVAuthorizationStatus.denied || status == AVAuthorizationStatus.restricted {
                return false
            } else {
                return true
            }
        }
    }
    
    //MARK:-------------------------------------3-是否可以使用定位
    open class var location: Bool {
        get {
            let status = CLLocationManager.authorizationStatus()
            if status == CLAuthorizationStatus.denied ||
                status == CLAuthorizationStatus.restricted ||
                status == CLAuthorizationStatus.notDetermined {
                return false
            } else {
                return true
            }
        }
    }
}
