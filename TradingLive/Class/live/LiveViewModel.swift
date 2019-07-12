//
//  LiveViewModel.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/25.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import NIMAVChat
import NELivePlayerFramework
import RxSwift


class LiveViewModel: JTBaseViewModel {
    
    var path = "rtmp://v1948666e.live.126.net/live/ca95ac5d775140849b59093215efe103?playTime=1561453088&playSecret=4ecce72cbf9e5102477b39a0b4f84921"
    var roomId = "26951750"
    
    
    //MARK:- 播放器监听的闭包
    
    ///播放器播放完成或播放发生错误时的消息通知。
    var livePlayFinished: ((LivePlayFinishedType)->())?
    ///播放第一帧
    var livePlayerPlay: (()->())?
    
    override init() {
        super.init()
        
        
        noti()
    }
    
    
    ///播放数据
    //    var liveRooms = Array<LiveRoomModel>()
    //    var liveIndex = 0
    
    
    
    
    //    func getNowRoom() -> LiveRoomModel {
    //        return liveRooms[liveIndex]
    //    }
    //
    //    func getLastRoom() -> LiveRoomModel {
    //        let index = liveIndex - 1
    //        if index < 0 {
    //            return liveRooms[liveRooms.count - 1]
    //        }
    //        return liveRooms[index]
    //    }
    //
    //    func getNextRoom() -> LiveRoomModel {
    //        let index = liveIndex + 1
    //        if index > liveRooms.count - 1 {
    //            return liveRooms[0]
    //        }
    //        return liveRooms[index]
    //    }
    
}


extension LiveViewModel {
    //MARK:- 播放器的监听事件
    ///创建监听
    func noti() {
        /**
         * 调用prepareToPlay后，播放器初始化视频文件完成后的消息通知
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerDidPreparedToPlay)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        // 播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
        /**
         * 调用prepareToPlay后，播放器初始化视频文件完成后的消息通知
         */
        /**
         * 播放器加载状态发生改变时的消息通知
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerLoadStateChanged)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放器播放完成或播放发生错误时的消息通知。
         * 携带UserInfo:{NELivePlayerPlaybackDidFinishReasonUserInfoKey : [NSNumber],
         *                       NELivePlayerPlaybackDidFinishErrorKey : [NSNumber]}
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerPlaybackFinished)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerPlaybackFinished(notification)
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放器播放结束原因的key
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name(rawValue: NELivePlayerPlaybackDidFinishReasonUserInfoKey))
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerPlaybackDidFinishReasonUserInfoKeyNoti(notification)
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放成功时，此字段为nil。播放器播放结束具体错误码。具体至含义见NELPPLayerErrorCode
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name(rawValue: NELivePlayerPlaybackDidFinishErrorKey))
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放器播放状态发生改变时的消息通知
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerPlaybackStateChanged)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerPlaybackState(notification)
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放器解码器打开后的消息通知，指示硬件解码是否开启
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerHardwareDecoderOpen)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerHardwareDecoderOpen(notification)
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放器第一帧视频显示时的消息通知
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerFirstVideoDisplayed)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerFirstVideoDisplayed(notification)
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放器第一帧音频播放时的消息通知
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerFirstAudioDisplayed)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * 播放器资源释放完成时的消息通知
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerReleaseSueecss)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * seek完成时的消息通知，仅适用于点播，直播不支持。
         * 携带UserInfo:{NELivePlayerMoviePlayerSeekCompletedTargetKey : [NSNumber],
         *              NELivePlayerMoviePlayerSeekCompletedTargetKey : [NSNumber]}
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerMoviePlayerSeekCompleted)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * seek失败时失败原因key
         */
        
        /**
         * seek完成时的时间
         */
        ///seek完成时的时间
        
        /**
         * 视频码流包解析异常时的消息通知
         */
        //        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPrearedToPlay), name: NSNotification.Name. NELivePlayerVideoParseError, object: nil)
        //        /**
        //         * 不同清晰度视频流的条数通知。
        //         * 携带UserInfo:{NELivePlayerMulitDefinitionMediaInfoKey : [NELivePlayerMulitDefinitionModel]}
        //         */
        //        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPrearedToPlay), name: NSNotification.Name.NELivePlayerMulitDefinitionMedia, object: nil)
        //
        //        /**
        //         * 即将自动切换至最低分辨率通知
        //         * 携带UserInfo:{NELivePlayerWillAutoSwitchDefinitionInfoKey : [NELivePlayerMulitDefinitionModel]}
        //         */
        //        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPrearedToPlay), name: NSNotification.Name.NELivePlayerWillAutoSwitchDefinition, object: nil)
        /**
         * 分辨率信息的key
         */
        
        /**
         * 播放过程中的Http状态码。
         * 携带UserInfo:{NELivePlayerHttpCodeResponseInfoKey : [NELivePlayerHttpCodeModel]}
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name.NELivePlayerHttpCodeResponse)
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerHttpCodeResponse(notification)
            })
            .disposed(by: rx.disposeBag)
        /**
         * Http状态模型获取的key
         */
        //Http状态模型获取的key
        
        /**
         * 播放器解码卡顿通知
         */
        //        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPrearedToPlay), name: NSNotification.Name.NELivePlayerDecodeNotFluent, object: nil)
        /**
         * seek失败时失败原因key
         */
        
        NotificationCenter.default.rx
            .notification(NSNotification.Name(rawValue: NELivePlayerMoviePlayerSeekCompletedErrorKey))
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * seek完成时的时间
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name(rawValue: NELivePlayerMoviePlayerSeekCompletedTargetKey))
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * 清晰度视频流条数信息key
         */
        //        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPrearedToPlay), name: NSNotification.Name(rawValue: NELivePlayerMulitDefinitionMediaInfoKey), object: nil)
        /**
         * 分辨率信息的key
         */
        //        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPrearedToPlay), name: NSNotification.Name(rawValue: NELivePlayerWillAutoSwitchDefinitionInfoKey), object: nil)
        /**
         * Http状态模型获取的key
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name(rawValue: NELivePlayerHttpCodeResponseInfoKey))
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * 预调度任务的key
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name(rawValue: NELivePlayerPreloadUrlKey))
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        /**
         * 预调度任务的状态key
         */
        NotificationCenter.default.rx
            .notification(NSNotification.Name(rawValue: NELivePlayerPreloadStateKey))
            .subscribe(onNext: { [weak self] (notification) in
                self?.NELivePlayerDidPrearedToPlay()
            })
            .disposed(by: rx.disposeBag)
        
        
        
        
    }
    
    
    
    
    
    
    
    
}











//MARK: - 播放器代理
extension LiveViewModel {
    
     func NELivePlayerDidPrearedToPlay() {
        print("初始化完成")
    }
    
    //播放过程中的Http状态码。
    @objc func NELivePlayerHttpCodeResponse(_ notification: Notification) {
        print("NELivePlayerHttpCodeResponse")
        let userInfo = notification.userInfo
        let reason = userInfo![NELivePlayerHttpCodeResponseInfoKey] as! NELivePlayerHttpCodeModel
        
        
        print(reason.code)
        print("----" + reason.header)
        
    }
    //是否开启硬件解码
    @objc func NELivePlayerHardwareDecoderOpen(_ notification: Notification) {
        print("NELivePlayerHardwareDecoderOpen")
        print("---%@", notification)
    }
    
    /**
     * 播放器播放状态发生改变时的消息通知
     */
    @objc func NELivePlayerPlaybackState(_ notification: Notification) {
        print("NELivePlayerPlaybackState")
        let userInfo = notification.userInfo
        
        print("---", notification)
        
    }
    /**
     * 播放器播放完成或播放发生错误时的消息通知。
     * 携带UserInfo:{NELivePlayerPlaybackDidFinishReasonUserInfoKey : [NSNumber],
     *                       NELivePlayerPlaybackDidFinishErrorKey : [NSNumber]}
     */
    @objc func NELivePlayerPlaybackFinished(_ notification: Notification) {
        print("NELivePlayerPlaybackFinished")
        
        print("---", notification)
        //weak var weakSelf = self
        
        let key = notification.userInfo![NELivePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        let a = Int((NELPMovieFinishReason.playbackEnded).rawValue)
        let b = Int((NELPMovieFinishReason.playbackError).rawValue)
        let c = Int((NELPMovieFinishReason.userExited).rawValue)
        
        var type = LivePlayFinishedType.other
        switch key  {
        case a:
            //直播结束
            type = .ended
            break
        case b:
            type = .error
            //通知返回的是播放异常
            break
        case c:
            type = .exited
            break
        default:
            type = .other
            break
        }
        
        livePlayFinished?(type)
        
    }
    
    /**
     *  播放器完成或播放发生错误时的消息通知。
     */
    @objc func NELivePlayerPlaybackDidFinishReasonUserInfoKeyNoti(_ notification: Notification) {
        print("NELivePlayerPlaybackDidFinishReasonUserInfoKeyNoti")
        
        
    }
    
    
    /**
     *  播放第一帧时候调用，说明已经连接上直播间了
     */
    
    @objc func NELivePlayerFirstVideoDisplayed(_ notification: Notification) {
        print("NELivePlayerFirstVideoDisplayed")
        livePlayerPlay?()
    }
}



enum LivePlayFinishedType {
    case ended
    case error
    case exited
    case other
}
