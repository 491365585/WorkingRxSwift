//
//  Refreshable.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/26.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift


protocol Refreshable {
    
}


extension Refreshable where Self : NSObject {
    func initRefreshHeader(_ scrollView: UIScrollView, onlyAnim: Bool = false, _ action: @escaping () -> Void) -> MJRefreshHeader {
        let header = MJRefreshNormalHeader(refreshingBlock: { action() })
        header?.lastUpdatedTimeLabel.isHidden = onlyAnim
        header?.stateLabel.isHidden = onlyAnim
        scrollView.mj_header = header
        
        return scrollView.mj_header
    }
    
//    func initRefreshFooter(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshFooter {
//        scrollView.mj_footer = (refreshingBlock: { action() })
//        return scrollView.mj_footer
//    }

    
    func initRefreshFooter(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshFooter {
        scrollView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { action() })
        return scrollView.mj_footer
        
    }
}



/* ============================ OutputRefreshProtocol ================================ */
// viewModel 中 output使用

protocol OutputRefreshProtocol {
    // 告诉外界的tableView当前的刷新状态
    var refreshStatus : Variable<TTRefreshStatus> {get}
}

extension OutputRefreshProtocol {
    func autoSetRefreshHeaderStatus(header: MJRefreshHeader?, footer: MJRefreshFooter?) -> Disposable {
        return refreshStatus.asObservable().subscribe(onNext: { (status) in
            switch status {
            case .beingHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                footer?.beginRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            case .noMoreData:
                footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
        })
    }
}
