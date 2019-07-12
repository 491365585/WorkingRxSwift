//
//  LiveIMViewModel.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/25.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import NIMSDK
import NIMAVChat
import NELivePlayerFramework
import RxSwift
import RxCocoa


// associatedtype 关键字 用来声明一个类型的占位符作为协议定义的一部分
protocol LiveIMViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

class LiveIMViewModel: JTBaseViewModel {

    
    var isLoginRoom = false
    
    
    var messageArr = Variable<[NIMMessage]>([])
//    {//Array<NIMMessage>())
//        didSet {
//            getAllOldMessage?()
//        }
//    }
    
    
    override init() {
        super.init()
        
        NIMSDK.shared().chatManager.add(self)
    }
}



extension LiveIMViewModel: LiveIMViewModelType {
    typealias Input = LXFInput
    typealias Output = LXFOutput
    
    struct LXFInput {
        // 网络请求类型

    }
    
    struct LXFOutput: OutputRefreshProtocol {
        // tableView的sections数据
        let sections: Driver<[LiveIMSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
//        // 告诉外界的tableView当前的刷新状态
        var refreshStatus = Variable<TTRefreshStatus>(.none)
        
        init(sections: Driver<[LiveIMSection]>) {
            self.sections = sections
            
        }
    }
    
    func transform(input: LiveIMViewModel.LXFInput) -> LiveIMViewModel.LXFOutput {
        let sections = messageArr.asObservable().map { [weak self] (models) -> [LiveIMSection] in
            // 当models的值被改变时会调用
            return [LiveIMSection(items: models)]
            }
            .asDriver(onErrorJustReturn: [])
        
        let output = LXFOutput(sections: sections)
        
        
        output.requestCommond.subscribe(onNext: {[weak self] isReloadData in
            print("???")
            self?.loadOldMessage({
                output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
            })
//            self.index = isReloadData ? 1 : self.index+1
//            lxfNetTool.rx.request(.data(type: input.category, size: 10, index: self.index))
//                .asObservable()
//                .mapArray(LXFModel.self)
//                .subscribe({ [weak self] (event) in
//                    switch event {
//                    case let .next(modelArr):
//                        self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
//                    case let .error(error):
//                    case .completed:
//                        output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
//                    }
//                }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}




extension LiveIMViewModel: NIMChatroomManagerDelegate {
    
    
    fileprivate func newMessage(_ name: String, text: String) {
        let message = NIMMessage()
        if name != "" {
            message.from = name
        }
        message.text = text
        messageArr.value = messageArr.value + [message]
    }
    
    ///进入聊天室的方法
    public func loadChatRoom() {
        
        weak var weakSelf = self
        //清除聊天
        messageArr.value.removeAll()
        let request = NIMChatroomEnterRequest()
        request.roomId = String("26951750")///从后台获取
        request.roomNickname = ""
        request.roomAvatar = ""//"http://jiataizhibo.lvcsmart.com/" + "static/public/img/default_avatar.png"
        ///不能频繁调用网易云login登录接口，不然会造成卡住页面并且没法进行任何操作，app变成假死状态，这不是我们期待的
        let userId = NIMSDK.shared().loginManager.currentAccount()
        if userId != "" {
            request.roomId = String("26951750")
            NIMSDK.shared().chatroomManager.add(self)
            NIMSDK.shared().chatroomManager.enterChatroom(request) { (error, room, chatRoom) in
                if error != nil {
                    ///有错误
                    print(error as Any)
                    print(error!._code)
                    print(error!._userInfo as Any)
                    print("loadChatRoomerror在这停顿")
                    if error!._code == 403 {
                        weakSelf?.newMessage("系统提示", text: "没有进入聊天室的权限")
                    }else {
                        weakSelf?.newMessage("系统提示", text: "切换聊天室过于频繁")
                    }
                    
                    return
                }
                ///连接聊天室成功
                if weakSelf == nil {
                    print("loadChatRoomweakSelftwo在这停顿")
                    
                    return
                }
                NIMSDK.shared().chatManager.add(weakSelf!)
                
            }
        }else {
            ///卡在这里？？？？？？
            NIMSDK.shared().loginManager.login(("1"), token: ("")) { [weak self] (error) in
                if error == nil {///先设置登录IM。
                    if weakSelf == nil {
                        print("loadChatRoomweakSelf在这停顿")
                        
                        return
                    }
                    
                    
                    
                    
                    
                    NIMSDK.shared().chatroomManager.add(weakSelf!)
                    NIMSDK.shared().chatroomManager.enterChatroom(request) { (error, room, chatRoom) in
                        if error != nil {
                            ///有错误
                            print(error as Any)
                            print(error!._code)
                            print(error!._userInfo as Any)
                            print("loadChatRoomerror在这停顿")
                            
                            return
                        }
                        ///连接聊天室成功
                        if weakSelf == nil {
                            print("loadChatRoomweakSelftwo在这停顿")
                            
                            return
                        }
                        NIMSDK.shared().chatManager.add(weakSelf!)
                        weakSelf!.isLoginRoom = true
                    }
                }else {
                    print("登录失败------请重试")
                    self?.newMessage("", text: "连接聊天室失败，请重试")
                    let mode = NIMChatroomIndependentMode()
                    request.mode = mode
                    
                    NIMChatroomIndependentMode.registerRequestChatroomAddressesHandler { (roomId, callback) in
                        //                                        NetworkTools.sharedTools.chatRoomAddrAccessToken(accid: nowUserInfo?.access_token, roomid: roomId, finished: { (result, error) in
                        //                                            if error == nil {
                        //                                                let results = result as AnyObject
                        //
                        //                                                if results["code"] as! Int == 200 {
                        //                                                    let rootDic = results["data"] as! [String: AnyObject]
                        //                                                    let addr = rootDic["addr"] as! [String]
                        //                                                    callback(error,addr)
                        //
                        //
                        //                                                }else {
                        //                                                    callback(error,[""])
                        //                                                }
                        //                                            }else {
                        //                                                callback(error,[""])
                        //                                            }
                        //                                        })
                    }
                    
                }
            }
        }
        
        
    }
    
    
    
    
    ///查询历史信息
    fileprivate func loadOldMessage(_ endBlock: (()->())? = nil) {
        
        let option = NIMHistoryMessageSearchOption()
        let now = Date()
        let time = now.timeIntervalSince1970
        let timeStamp = Int(time)
        option.startTime = TimeInterval(timeStamp - 1800)
        option.limit = 100
        option.order = .asc
        NIMSDK.shared().chatroomManager.fetchMessageHistory(String("26951750"), option: option) { [weak self] (error, messages) in
            endBlock?()
            if error != nil {
                print(error as Any)
                print("loadOldMessage在这停顿")
                
                return
            }
            print("历史消息--------")
            print(messages?.count as Any)
            self?.messageArr.value.removeAll()
            for message in messages! {
                self?.messageArr.value.append(message)
            }
        }
        NIMSDK.shared().chatManager.add(self)
        
        
    }
    
    
}




//MARK: - NIMChatManagerDelegate代理
extension LiveIMViewModel: NIMChatManagerDelegate {
    func chatroom(_ roomId: String, connectionStateChanged state: NIMChatroomConnectionState) {
        switch state {
        case NIMChatroomConnectionState.enterFailed:
            print("进入聊天室失败")
            newMessage("", text: "进入聊天室失败")
            break
        case NIMChatroomConnectionState.entering:
            print("进入聊天室...")
            newMessage("", text: "进入聊天室...")
            break
        case NIMChatroomConnectionState.enterOK:
            print("进入聊天室成功")
            loadOldMessage()
            newMessage("", text: "进入聊天室成功")
            break
        case NIMChatroomConnectionState.loseConnection:
            print("和聊天室失去连接")
            newMessage("", text: "和聊天室失去连接")
            break
        @unknown default:
            print("和聊天室失去连接")
            newMessage("", text: "和聊天室失去连接")
        }
        print(state)
    }
    
    func chatroom(_ roomId: String, autoLoginFailed error: Error) {
        print(error)
    }
    
    ///接受消息的回调
    func onRecvMessages(_ messages: [NIMMessage]) {
        print(messages as Any)
        for message in messages {
            messageArr.value.append(message)
        }
    }
    func send(_ message: NIMMessage, didCompleteWithError error: Error?) {
        if message.session?.sessionType != NIMSessionType.chatroom {
            return
        }
        print(message as Any)
        if error != nil {
            print("send在这停顿")
            newMessage("系统提示", text: "您的信息: \"" + (message.text ?? "" )! + "\" 发送失败")
            return
        }
        print()
        messageArr.value.append(message)
    }
    
    
    
    ///发送聊天信息
    public func sendMessage(message: String) {
        ///要发给谁
        let session = NIMSession.init(String("我"), type: .chatroom)//) session:@"user" type:NIMSessionTypeP2P];
        ///你要发送的信息
        let mess = NIMMessage()
        mess.text = message
        
        newMessage("我", text: message)
        
        do {
            try NIMSDK.shared().chatManager.send(mess, to: session)
            
        }catch let error{
            print(error)
        }
    }
    
}
