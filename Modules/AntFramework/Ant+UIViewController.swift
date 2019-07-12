//
//  Ant+UIViewController.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2018/1/29.
//

import Foundation

public class AntClassUIViewController: NSObject {
    
}

public class AntObjectUIViewController: NSObject {
    
    let value: UIViewController
    
    init(_ value: UIViewController) {
        self.value = value
    }
    
    public func push(_ viewController: UIViewController, animate: Bool = true) {
        
        guard let nc = self.value.navigationController else {
            return
        }
        
        nc.pushViewController(viewController, animated: animate)
    }
    
    public func pushHiddenBottomBar(_ viewController: UIViewController, animate: Bool = true) {
        
        guard let nc = self.value.navigationController else {
            return
        }
        
        viewController.hidesBottomBarWhenPushed = true
        
        nc.pushViewController(viewController, animated: animate)
    }
    
    public func pop(_ viewController: UIViewController? = nil, animate: Bool = true) {
        
        guard let nc = self.value.navigationController else {
            return
        }
        
        if let vc = viewController {
            nc.popToViewController(vc, animated: animate)
        } else {
            nc.popViewController(animated: animate)
        }
    }
    
    public func popRoot(_ animate: Bool = true) {
        
        guard let nc = self.value.navigationController else {
            return
        }
        
        nc.popToRootViewController(animated: animate)
    }
    
}

extension UIViewController {
    
    public static var ant: AntClassUIViewController {
        return AntClassUIViewController.init()
    }
    
    public var ant: AntObjectUIViewController {
        return AntObjectUIViewController.init(self)
    }
}



















