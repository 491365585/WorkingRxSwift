//
//  NSObject+Extension.swift
//  JiuyingTrade
//
//  Created by Anthony on 2019/6/11.
//  Copyright © 2019 久盈. All rights reserved.
//

import Foundation

extension NSObject {
    
    func getIvar(name: String) -> Any? {
        
        guard let _var = class_getInstanceVariable(type(of: self), name) else {
            return nil
        }
        
        return object_getIvar(self, _var)
    }
    
}

