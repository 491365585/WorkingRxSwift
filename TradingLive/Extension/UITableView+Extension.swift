//
//  UITableView+Extension.swift
//  JiuyingTrade
//
//  Created by Anthony on 2019/3/22.
//  Copyright © 2019 久盈. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UITableView {
    
    
    /// 设置自动撑开 Header Footer View
    /// - Parameters:
    ///   - headerV: tableView 顶部的view
    ///   - footerV: tableView 底部的view
    public func setupHeaderFooterV(headerV: UIView?, footerV: UIView?) {
        if let headerV = headerV {
            setupHeaderFooterV(&tableHeaderView, contentV: headerV)
        }
        if let footerV = footerV {
            setupHeaderFooterV(&tableFooterView, contentV: footerV)
        }
    }
    
    /// 更新 headerFooterV 的 size
    public func updateHeaderFooterVSize(_ height: CGFloat? = nil) {
        updateSize(&tableHeaderView, height)
        updateSize(&tableFooterView, height)
    }
    /// 设置自动撑开 Header Footer View
    ///
    /// - Parameters:
    ///   - headerFooterV: headerView & FooterView
    ///   - contentV: 内容 （通过约束自动撑开）
    private func setupHeaderFooterV(_ headerFooterV: inout UIView?,
                                    contentV: UIView) {
        let view = UIView()
        view.addSubview(contentV)
        contentV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        headerFooterV = view
        updateSize(&headerFooterV)
    }
    
    /// 更新 headerFooterV 的 size
    ///
    /// - Parameter headerFooterV: 头部尾部的V
    private func updateSize(_ headerFooterV: inout UIView?, _ getHeight: CGFloat? = nil) {
        guard let view = headerFooterV else { return }
        
        // 需要布局子视图
        view.setNeedsLayout()
        // 立马布局子视图
        view.layoutIfNeeded()
        
        let height = view
            .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = view.frame
        frame.size.height = height
        if let getHeight = getHeight {
            frame.size.height = getHeight
        }
        view.frame = frame
        // 重新设置tableHeaderView
        headerFooterV = view
    }
}
