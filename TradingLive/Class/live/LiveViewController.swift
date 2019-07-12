//
//  LiveViewController.swift
//  familyArtwork
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import SVProgressHUD
import NVActivityIndicatorView
import SDWebImage
import IQKeyboardManagerSwift
import UIKit
import NIMSDK
import NIMAVChat
import NELivePlayerFramework
import Kingfisher
import RxSwift
import RxCocoa
import RxDataSources

class LiveViewController: UIViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        setupUI()
        
        
        let button = UIButton(frame: CGRect(x: 10, y: 30, width: 50, height: 25))
        button.setTitle("返回", for: .normal)
        button.rx.tap.subscribe { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        view.addSubview(button)
        
    }
    
    // 3. 在deinit，禁止自动旋转
    deinit {
        removePlayer()
        print("直播页面确认被销毁")
        allowAutorotate(allowed: false)
        
    }
    
    ///清除所有需要清除的信息
    fileprivate func removePlayer() {
        allowAutorotate(allowed: false)
        NIMSDK.shared().chatroomManager.exitChatroom( String(viewModel.roomId), completion: { (error) in
            
        })
        if livePlayer != nil {
            livePlayer.shutdown()
            livePlayer.view.removeFromSuperview()
            livePlayer = nil;
            
            print("播放器确定被销毁")
        }
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    
    
    //MARK:- 播放器相关
    ///播放器
    var livePlayer: NELivePlayerController!
    var liveSet: LiveSetView!
    ///错误信息
    ///播放器窗口
    let playerView = UIView()
    
    var backImage = UIImageView(image: UIImage(named: "洛奇背景图"))
    
    ///创建一个保存开始页面的view
    let startView = UIView()
    
    ///创建一个模糊效果
    let blurEffect = UIBlurEffect(style: .light)
    ///模糊view
    var blurView: UIVisualEffectView!
    
    
    fileprivate let viewModel = LiveViewModel()
    
}


//MARK: - 部署
extension LiveViewController {
    
    fileprivate func setupUI() {
        
        
        
        setupPlayer()
        setupStartView()
        setupSet()
        setupViewModel()
        updateRoom(index: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiverNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    ///创建播放器
    fileprivate func setupPlayer() {
        
        NELivePlayerController.setLogLevel(.LOG_ERROR)
        do {
            //播放器初始化
            livePlayer = try NELivePlayerController(contentURL: URL(string: viewModel.path))//""))//NELivePlayerController(contentURL: ,needConfigAudioSession:true)
            
        }catch let error{
            SVProgressHUD.showError(withStatus: "发生未知错误")
            print(error)
        }
        
        view.addSubview(playerView)
        
        playerView.addSubview(livePlayer.view)
        
        playerView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(view.snp.height)
        }
        livePlayer.view.snp.makeConstraints { (make) in
            make.left.equalTo(playerView.snp.left)
            make.right.equalTo(playerView.snp.right)
            make.top.equalTo(playerView.snp.top)
            make.bottom.equalTo(playerView.snp.bottom)
        }
        //缓冲策略有直播低延时模式、直播流畅模式以及点播抗抖动模式，如果是直播，建议采用低延时模式或流畅模式，如果是点播或本地视频，建议采用抗抖动模式
        livePlayer.setBufferStrategy(.fluent)
        //设置播放idx多分辨率文件时，遇到卡顿是否自动切换低分辨率
        //        livePlayer.autoSwitchDefinition = false
        
        
        //缩放模式
        livePlayer.setScalingMode(.fill)
        //设置是否自动播放
        livePlayer.shouldAutoplay = true
        livePlayer.setPlaybackTimeout(15 * 1000)
        livePlayer.prepareToPlay()//开启播放
        
        
        
        
        allowAutorotate(allowed: true)
        
    }
    
    
    ///创建模糊view和加载动画
    fileprivate func setupStartView() {
        
        backImage.frame = view.frame
        //创建一个承载模糊效果的视图
        blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.frame
        
        
        
        
        
        view.addSubview(startView)
        startView.addSubview(backImage)
        startView.addSubview(blurView)
        startView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(view.snp.height)
        }
        
        backImage.snp.makeConstraints { (make) in
            make.left.equalTo(startView.snp.left)
            make.top.equalTo(startView.snp.top)
            make.right.equalTo(startView.snp.right)
            make.height.equalTo(startView.snp.height)
        }
        
        blurView.snp.makeConstraints { (make) in
            make.left.equalTo(startView.snp.left)
            make.top.equalTo(startView.snp.top)
            make.right.equalTo(startView.snp.right)
            make.height.equalTo(startView.snp.height)
        }
        
        
    }
    
    
    
    ///创建控制视图
    fileprivate func setupSet() {
        liveSet = LiveSetView()
        liveSet.updateScroll(true)
        if #available(iOS 11.0, *) {
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
            // Fallback on earlier versions
        }
        view.addSubview(liveSet)
        
        
        liveSet.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        
        weak var weakSelf = self
        
        
        
        liveSet.bigClick = { isBig in
            
            if isBig {
                //需要缩小
                
                let value = UIInterfaceOrientation.portrait.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                
            }else {
                //需要放大
                
                let value = UIInterfaceOrientation.landscapeRight.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                
                
            }
        }
        
        
        liveSet.loadClick = { [weak self] in
            weakSelf!.loadPlay(url: URL(string: self?.viewModel.path ?? ""))
        }
        
        
        
        liveSet.mainViewUI = { [weak self] offset, isUpdata, index in
            guard let self = self else {
                return
            }
            //print(offset)
            if offset == liveHeight {
                //居中
                ///重新回到原来的框架大小
                weakSelf!.liveSet.updateControl(0)
                weakSelf!.playerView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.view.snp.top)
                })
                weakSelf!.startView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.view.snp.top)
                })
                
            }else if offset > liveHeight {
                //往上拖动
                let offsetY = offset - liveHeight
                weakSelf!.liveSet.updateControl(-offsetY)
                weakSelf!.playerView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.view.snp.top).offset(-offsetY)
                })
                weakSelf!.startView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.view.snp.top).offset(-offsetY)
                })
            }else if offset < liveHeight {
                //往下拖动
                let offsetY = liveHeight - offset
                weakSelf!.liveSet.updateControl(offsetY)
                weakSelf!.playerView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.view.snp.top).offset(offsetY)
                })
                weakSelf!.startView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.view.snp.top).offset(offsetY)
                })
            }
            if isUpdata {
                //需要更新直播间,先断开聊天室
                NIMSDK.shared().chatroomManager.exitChatroom( String(self.viewModel.roomId), completion: { (error) in
                    
                })
                
                weakSelf!.view.layoutIfNeeded()
                weakSelf!.updateRoom(index: 0)
            }
            
        }
        
        ///f回退手势
        
        
    }
    
    
    
    fileprivate func setupViewModel() {
        ///播放器播放完成或播放发生错误时的消息通知。
        viewModel.livePlayFinished = { [weak self] in
            if let player = self?.livePlayer {
                if player.isPlaying() {
                    //没有在播放
                    self?.startView.alpha = 1
                    self?.liveSet.showView(index: 1)
                    return
                }
            }
            
            switch $0 {
            case .ended:
                //直播结束
                self?.startView.alpha = 1
                self?.liveSet.showView(index: 2)
            case .error:
                //通知返回的是播放异常
                self?.startView.alpha = 1
                self?.liveSet.showView(index: 2)
            case .exited:
                break
            case .other:
                break
            }
        }
        ///开始播放
        viewModel.livePlayerPlay = { [weak self] in
            
            self?.liveSet.showView(index: 3)
            self?.startView.alpha = 0
            ///成功连接上直播间，在这里添加热度
            //            self?.addHot()
        }
    }

    
    
   
}

//MARK: - 播放器控制方法
extension LiveViewController {
    ///更新room
    fileprivate func updateRoom(index: Int) {
        
        
        liveSet.showView(index: 0)
        //        liveSet.shopArr.removeAll()
        
        
        liveSet.updateImage(homePath, next: homePath)
        backImage.kf.setImage(with: URL(string: homePath), placeholder: UIImage(named: "洛奇背景图"))
        
        
        loadPlay(url: URL(string: viewModel.path))
        //        liveSet.setShopArr(goodsList: getNowRoom().goodsList)
        
        startView.alpha = 1
        
    }
    
    
    
    ///重新加载直播间
    fileprivate func loadPlay(url: URL?) {
        guard let url = url else {
            return
        }
        if livePlayer == nil {
            
            print("loadplay在这停顿")
            return
        }
        let config = NELPUrlConfig()
        
        //        livePlayer.switchContentUrl(url)
        livePlayer.switchContentUrl(url, config: config)
        //livePlayer.prepareToPlay()
        
        
        liveSet.updateUI()
        
        
        
        
    }
    
}



//MARK: - 屏幕旋转控制
extension LiveViewController {
    // 1. 定义一个方法，控制是否要自动旋转
    func allowAutorotate(allowed: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.shouldAutorotate = allowed
    }
    
    // 4. 重写支持的屏幕方向 （可以不写）
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown

    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        liveSet.isOrient = false
    }
    
    override var shouldAutorotate: Bool {
        get {
            return true
        }
    }

    @objc func receiverNotification(){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if !appDelegate!.shouldAutorotate {
            //如果没开启旋转屏幕不作处理
            return
        }
        let orient = UIDevice.current.orientation
        if orient == .portraitUpsideDown{
            //倒立不作处理
            return
        }
        
        switch orient {
        case .portrait :
            print("屏幕正常竖向")
            livePlayer.setScalingMode(.fill)
            isHorizontal = false
            break
        case .portraitUpsideDown:
            print("屏幕倒立")
            isHorizontal = false
            break
        case .landscapeLeft:
            print("屏幕左旋转")
            livePlayer.setScalingMode(.none)
            
            break
        case .landscapeRight:
            print("屏幕右旋转")
            livePlayer.setScalingMode(.none)
            break
        default:
            break
        }
       
        liveSet.updateUI(orient != .portrait)
        
        view.layoutIfNeeded()

    }

    override func viewDidDisappear(_ animated: Bool) {

        allowAutorotate(allowed: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        allowAutorotate(allowed: true)
    }
    
}



