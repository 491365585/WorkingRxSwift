//
//  Api+ Video.swift
//  RongJinFramework
//
//  Created by Anthony on 2019/4/12.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
// MARK: - 音频
extension Url {
    
    /// audio
    open class var video: String {
        get {
            return RongJinManager.httpHost + "/Video"
        }
    }
}


extension Api {
    
    /// 视频列表
    ///
    /// - Parameters:
    ///   - page: 页码
    ///   - length: 页长
    ///   - type: 类型# 0:最新；1：资讯；2：小讲堂；3：交易访谈；4：交易者说
    ///   - endBlock: 回调
    public func  videoGetReportList(page: Int, length: Int, endBlock: (([RongJinAudio]?, String)->())?) {
        
        var info = [String: Any].init()
        
        info["action"] = "getAudioList"
        
        info["page"] = "\(page)"
        info["length"] = "\(length)"
        
        Api.request(Url.audio, parameters: info, successBlock: { (returnData) in
            
            let info = Api.dataDictArray(returnData)
            if let returnArray = info.data {
                
                var models = [RongJinAudio].init()
                
                for dict in returnArray {
                    if let model = RongJinAudio.deserialize(from: dict) {
                        
                        models.append(model)
                    }
                }
                
                if let subBlock = endBlock {
                    subBlock(models, info.msg)
                }
                
            } else {
                if let subBlock = endBlock {
                    subBlock(nil, info.msg)
                }
            }
            
        }) { (error) in
            if let subBlock = endBlock {
                subBlock(nil, "网络请求失败")
            }
        }
    }
    
    
    
    /// 视频点赞
    ///
    /// - Parameters:
    ///   - audioId: 音频id
    ///   - endBlock: 回调
    public func  videoGetStar(audioId: String?, option: String, endBlock: ((Int, String)->())?) {
        
        var info = [String: Any].init()
        
        info["action"] = "likeIconClick"
        
        info["audioId"] = audioId
        
        info["option"] = option
        
        Api.request(Url.audio, parameters: info, successBlock: { (returnData) in
            
            let code = Api.getCode(returnData)
            let msg = Api.getMsg(returnData)
            if code == 200{
                
                if let subBlock = endBlock {
                    subBlock(code, msg)
                }
                
            } else {
                if let subBlock = endBlock {
                    subBlock(code, msg)
                }
            }
            
        }) { (error) in
            if let subBlock = endBlock {
                subBlock(100, "网络请求失败")
            }
        }
    }
    
    /// 视频收藏
    ///
    /// - Parameters:
    ///   - audioId: 音频id
    ///   - endBlock: 回调
    public func  videoGetCollection(audioId: String?, option: String, endBlock: ((Int, String)->())?) {
        
        var info = [String: Any].init()
        
        info["action"] = "collIconClick"
        
        info["audioId"] = audioId
        
        info["option"] = option
        
        Api.request(Url.audio, parameters: info, successBlock: { (returnData) in
            
            let code = Api.getCode(returnData)
            let msg = Api.getMsg(returnData)
            if code == 200{
                
                if let subBlock = endBlock {
                    subBlock(code, msg)
                }
                
            } else {
                if let subBlock = endBlock {
                    subBlock(code, msg)
                }
            }
            
        }) { (error) in
            if let subBlock = endBlock {
                subBlock(100, "网络请求失败")
            }
        }
    }
    
    ///likeUserlist视频点赞人数
    //
    /// - Parameters:
    ///   - audioId: 音频id
    ///   - endBlock: 回调
    public func  videoGetStarPeople(audioId: String, page: Int = 1, length: Int = 6,  endBlock: (([RongJinAudioAvatar]?, Int)->())?) {
        
        var info = [String: Any].init()
        
        info["action"] = "likeUserlist"
        
        info["audioId"] = audioId
        
        info["page"] = "\(page)"
        
        info["length"] = "\(length)"
        
        Api.request(Url.audio, parameters: info, successBlock: { (returnData) in
            
            let info = Api.dataDict(returnData)
            
            if let model = RongJinAudioPeople.deserialize(from: info.data) {
                if let subBlock = endBlock {
                    subBlock(model.users, model.count)
                }
            }else {
                if let subBlock = endBlock {
                    subBlock(nil, 0)
                }
            }
            
            
        }) { (error) in
            if let subBlock = endBlock {
                subBlock(nil, 0)
            }
        }
    }
    
    ///CollLikeIconView视频是否点赞收藏
    //
    /// - Parameters:
    ///   - audioId: 音频id
    ///   - endBlock: 回调
    public func  videoGetStarColl(audioId: String?, endBlock: ((RongJinCollLike?, String)->())?) {
        
        var info = [String: Any].init()
        
        info["action"] = "collLikeIconView"
        
        info["audioId"] = audioId ?? ""
        
        Api.request(Url.audio, parameters: info, successBlock: { (returnData) in
            
            let info = Api.dataDict(returnData)
            
            if let model = RongJinCollLike.deserialize(from: info.data) {
                if let subBlock = endBlock {
                    subBlock(model, info.msg)
                }
            }else {
                if let subBlock = endBlock {
                    subBlock(nil, info.msg)
                }
            }
            
        }) { (error) in
            if let subBlock = endBlock {
                subBlock(nil, "网络请求失败")
            }
        }
    }
}
