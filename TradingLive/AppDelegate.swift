//
//  AppDelegate.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/24.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
#if DEBUG
import CocoaDebug
#endif
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var shouldAutorotate = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        CocoaDebug.enable()
        
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        let screen = UIScreen.main.bounds        //获得设备尺寸
        self.window = UIWindow.init(frame: screen)    //给“输出窗口“实例化并设置frame
        let nv = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = nv   //将“输出窗口”的根视图设置为导航栏
        self.window?.makeKeyAndVisible()        //  设置"输出窗口可见"
        
        return true
    }
    
    public func print<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, color: UIColor = .white) {
        swiftLog(file, function, line, message, color, false)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if shouldAutorotate {
            return .allButUpsideDown
        } else {
            return .portrait
        }
    }
    
    
}

