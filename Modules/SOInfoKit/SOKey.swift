//
//  SOKey.swift
//  GoldenFish
//
//  Created by 马义飞 on 2017/12/31.
//  Copyright © 2017年 马义飞. All rights reserved.
//

import Foundation

public class SOKey {
    
}

extension SOKey {
    
    /// 高德地图-站点分布-Key
    public class var gaodeStationKey: String {
        get {
            return "9bf2e87abd3ebc2208b50dab0b0db857"
        }
    }
    
    /// 用户数据缓存
    public class var userSave: String {
        get {
            return "GoldenUserSave"
        }
    }
    
    /// key
    public class var fishKey: String {
        get {
            return "yellowfish"
        }
    }
    
    /// 密码
    public class var password: String {
        get {
            return "password"
        }
    }
    
    /// 友盟的Key
    public class var umengKey: String {
        get {
            return "5816edb504e20516b1000c78"
        }
    }
    
    // 友盟分享回调地址
    public class var umSharedRedirectURL: String {
        get {
            return "http://mobile.umeng.com/social"
        }
    }
    
    /// 微信的Key
    public class var wechatKey: String {
        get {
            return "wxe3c21f345833e6c4"
        }
    }
    
    /// QQ的Key
    public class var QQ: String {
        get {
            return "1106175314"
        }
    }
    
    /// 微博的Key
    public class var sinaKey: String {
        get {
            return "4167953500"
        }
    }
    
    /// 微博的Secret
    public class var sinaSecret: String {
        get {
            return "ba2ffaad9e15c1d37f164dfb89a03c26"
        }
    }
    
    /// 微博的Callback
    public class var sinaCallBack: String {
        get {
            return "https://sns.whalecloud.com/sina2/callback"
        }
    }
    
    // 微信秘钥
    public class var weChatSecret: String {
        get {
            return "34e72d57b8ff2940f023ad44c39f2bb2"
        }
    }
    
    // QQ秘钥
    public class var QQSecret: String {
        get {
            return "Jwxalzv3I6CkMQwu"
        }
    }
    
    // 支付宝钱包的AppId
    public class var aliPayAppId: String {
        get {
            return "2016091200492042"
        }
    }
    
    // 支付宝钱包的网关
    public class var aliPayGateway: String {
        get {
            return "https://publicapi.alipaydev.com/gateway.do"
        }
    }
    
    // 支付宝钱包的私钥
    public class var aliPaySiyao: String {
        get {
            return "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDARYsRBvVDXEjx/cZDmnhVGsZfbgTNH8SN+eLkAnIWTKZjRvwXJf8wJJDk+CKMpNOp6bpzmri/0OWJtxTzK4tRzxG5NOiB2QVme2+UI7n/jJWmf1/D5f2BAkkHqqoFJr/akTQMogxIcdWhHJcY/FH+dsXpW+MeKxaayRwLCWWQatqPLzCQyFbOMh1DQUZSfXu+dhmagiYZOBL+S1BCMiXBR09U8lZnOpPDmbvCXneocwqVMEIKkeV6Ol/kohXdWy0YvIlnFxHEzxPzNiO4JOsS0frV0N+t4LPIEfxlDEFSMu7NrzbPO7sak0H7fg1H4x7PRnA3w/BclScUXxVmmLCDAgMBAAECggEBAIoFIegOK5+4LnDwMBO1Xi4Rc1drvayV4l3chKASlV0mlsZrXWkskHw5s316FisJ4xt0ubBk37xqM2vhbfuFRZRrZZiiv0j+xd6kOxuHbexhOcf0ZYVVot2qC0yimTvrbgty8n8jEFgsxyLJSDnaXu2gyz9SA75TRf3E4gmWLD83BAhY+XSwWdEuU0x9oJ3FaQwMLu7qxa3I5Qww2gdX+sMg0lhuN15s4jh0JHZ4NaewlOOu7g6zQSQUVqv82SjKFNFSOxwmwGD4tDKEtDkXTN94Frq9NE8F+b2B0w2WECF069DQz2b70DFyrbXpav8WA3JRmEHN23hG4M6JQIc6SFkCgYEA/KQm2JbioCiv1b6auDG3FsIkBGGX3Yo2GZKxA7u1WO6/wPbKsnbCad9sm4/Lu6fH5mXAr6rtgBEu+0AXmD9ET4TmSHON7tYTx7EA9iw32F8WDTAJl4Gkv0tMwSOpPEGb0f631EvnSORIzNgpxFQahqMZOG0TomjdWS57V0n77VcCgYEAwtPtcmhoBq8g/eqF7qYga9hRWS/1vBjYgTnQCfk5Oy7PdtpwGg/jRypPoaOTQCswGSSR53tycXCcdOUf3gGsuU6rVXAHgl5qH+iMCya/YVFv8NTzt77/fUD/MFf2EXrN98IPl+Kk+qr6v4hGj89eS5uC8nrdgaFRxLc9DL7l7rUCgYBxSP4uQsJORNBLzRM9ovVRXC6gVE6vxYjqwK9lWCdCQJR1Z3SOv9f/d3MQ8lLNy7dEZb4YR1IGCi6B9URfPYdZDOPh+wba4N2vvnwK5tsHx+NweGjkqfqA2LgLjVaVcWn4qPovVPXE2phGWmuoIHpggwQNHEQgoFsY4VHnW0J/MwKBgQCRD3JQKOSrdWG/LQsjsZWaNqn7SOaBYo5xSTZY9rNiGWxnNiUZgpLaveokk8JjmMRrNAteq09+nzYe4ypjBiQwpR50ssEklF+3+lGrS+Ja92O9kREV0qQwAmD/Ab85LJKG0nsBv8LO0Nd6HSONWjz/Vn6dRFYA2rgjG7vc7ZYNsQKBgQDW4CX7nFP77yBsLqgDyKdgviVvwahoXeNpBh4tD6pC4M9vRnt2VY5raB+sf9y8roQqRO/XEYAJL76zSJ/iD6jHUSuK4dZ5foTR4WFyD4MD98YLHVCjxPGQBEHB5aO0pcRchYGKB7Q4emSemS9DwJxojoIofUEbPlynEghaQUv0iQ=="
        }
    }
    
    
    // 上一次更新资金账户的时间
    public static var standardLastUpdateFuture: String {
        get {
            return "standardLastUpdateFuture"
        }
    }
}



















