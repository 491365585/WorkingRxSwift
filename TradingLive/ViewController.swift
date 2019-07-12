//
//  ViewController.swift
//  TradingLive
//
//  Created by Anthony on 2019/6/24.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        navigationController?.isNavigationBarHidden = true
        
        setupTableView()
        
        setupViewModel()
        
        
        
        
    }


    let tableView = UITableView()
    fileprivate var array = Array<String>()
    let items = Observable.just(
        [SectionModel(model: "",
                      items: ["live","Fold"])
        ])
}


extension ViewController {
    
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.rowHeight = 60

        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
    }
    
    
    fileprivate func setupViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String>>(configureCell: { [weak self] ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: "UITableViewCell")!
            cell.textLabel?.text = item
            
            return cell
        })
        
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        
        //获取索引
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] in
                //print("选中项的indexPath为：\(indexPath)")
                self?.tableView.deselectRow(at: $0, animated: true)
                switch $0.row {
                case 0:
                    self?.navigationController?.pushViewController(LiveViewController(), animated: true)
                    break
                case 1:
                    self?.navigationController?.pushViewController(FoldViewController(), animated: true)
                    break
                default:
                    break
                }
            })
            .disposed(by: rx.disposeBag)
    }
}



extension ViewController {
    override func viewDidAppear(_ animated: Bool) {
        
    }
}


extension ViewController: UIScrollViewDelegate {
    
}
