//
//  HelloViewController.swift
//  TradingLive
//
//  Created by Anthony on 2019/7/22.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import RxSwift


//MARK: - <#这是用于什么地方#>   的ViewController
//  ---------------------------------------------------------------------------
// |                          MARK: - 属性(所有属性的创建)                        |
//  ---------------------------------------------------------------------------
//MARK: - 属性(所有属性的创建)
class HelloViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //首次加载
        setupFirstModel()
        
        //部署UI
        setupUI()
        //部署ViewModel
        setupViewModel()
        //部署UI约束
        setupConstraint()
    }
    
    deinit {
        print("HelloViewController isDismiss")
    }
}

//  ---------------------------------------------------------------------------
// |           MARK: - 首次加载用到的数据(提供首次调用的数据,在UI显示之前)              |
//  ---------------------------------------------------------------------------
extension HelloViewController {
    
    fileprivate func setupFirstModel() {
        
        
        
    }
    
}


//  ---------------------------------------------------------------------------
// |                              MARK: - 部署(UI创建)                           |
//  ---------------------------------------------------------------------------
extension HelloViewController {
    
    fileprivate func setupUI() {
        
        
        
    }
    
}

//  ---------------------------------------------------------------------------
// |                     MARK: - UI约束层(UI的约束统一放置于此)                     |
//  ---------------------------------------------------------------------------
extension HelloViewController {
    
    fileprivate func setupConstraint() {
        
        
        
    }
    
}

//  ---------------------------------------------------------------------------
// |                       MARK: - UIModel(针对viewModel)                       |
//  ---------------------------------------------------------------------------
extension HelloViewController {
    
    fileprivate func setupViewModel() {
        
        
        
    }
    
}

//  ---------------------------------------------------------------------------
// |                 MARK: - UI逻辑层(针对UI,比如UI刷新,UI交互)                     |
//  ---------------------------------------------------------------------------
extension HelloViewController {
    
    
    
}

//  ---------------------------------------------------------------------------
// |                       MARK: - 私有(针对一些私有事件)                          |
//  ---------------------------------------------------------------------------
extension HelloViewController {
    
    
    
}


//---------------------------------------------------------------------------

//  ---------------------------------------------------------------------------
// |                    MARK: - 公开(给与外界调用的方法)                           |
//  ---------------------------------------------------------------------------
extension HelloViewController {
    
    
    
}

//---------------------------------------------------------------------------




//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------


//  ---------------------------------------------------------------------------
// |                    MARK: - ViewController生命周期                           |
//  ---------------------------------------------------------------------------


//MARK: - ViewController生命周期
extension HelloViewController {
    
    // 加载视图时会调用该方法
    override func loadView() {
        super.loadView()
        //print("加载视图")
        
        
    }
    
    // 当加载视图结束时调用该方法
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        //print("加载视图结束")
    //
    //
    //    }
    
    //将要布局子视图
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //print("视图即将被布局")
    }
    
    //已经布局子视图
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //print("视图已经被布局")
    }
    
    // 视图将要显示时调用该方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("视图即将显示")
        
        
    }
    
    // 当视图已经显示时调用该方法
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("视图已经显示")
        
        
    }
    
    // 当视图将要消失时调用该方法
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("视图即将消失")
        
        
    }
    
    // 当时图已经消失时调用该方法
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("视图已经消失")
        
        
    }
    
    // 当接收到内存警告时会执行这个方法
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory Warning !!!")
    }
    
    
}
