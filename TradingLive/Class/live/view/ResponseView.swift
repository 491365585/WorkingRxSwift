//
//  ResponseView.swift
//  familyArtwork
//
//  Created by mac on 2018/9/1.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import UIKit
class ResponseView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view//view == self?nil:view;
    }
}
