//
//  FoldViewController.swift
//  TradingLive
//
//  Created by Anthony on 2019/7/4.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import RongJinFramework
import RxSwift
import RxCocoa

class FoldViewController: UIViewController {
    
    var index = 0
    
    var disposeBag = DisposeBag()
    
    @objc func timerClick() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//            .map{ _ in
//
//                self.countDownSeconds - 1
//
//            }
//            .filter{
//                $0 >= 0
//            }
//            .asDriver(onErrorJustReturn: 0)
        
        setupUI()
        let button = UIButton(frame: CGRect(x: 10, y: 30, width: 50, height: 25))
        button.setTitle("返回", for: .normal)
        button.rx.tap.subscribe { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: button.rx.disposeBag)
        
        view.addSubview(button)
        var button1 = UIButton(frame: CGRect(x: mainWidth - 60, y: 30, width: 50, height: 25))
        button1.setTitle("首页", for: .normal)
        button1.rx.tap
            .subscribe(onNext: { _ in
                self.begin()
            })
        

        
        

        
//            .bind(to: button1.rx.title(for: .normal))
//            .disposed(by: button1.rx.disposeBag)
//        button1.rx.tap.subscribe { [weak self] (_) in
//            guard let self = self else {
//                return
//            }
//            ///创建一串view并放置，循环往下翻
//            for eView in self.moreView {
//                self.view.addSubview(eView)
//                eView.setupTop()
//                let a = FoldModel(self.getImage1(), self.getImage1())
//                eView.getBackImage(a.topImage)
//                eView.getPositiveImage(a.topBackImage)
//            }
//
//            self.getAnim(self.moreView.count - 1)
//
//        }
        
        view.addSubview(button1)
    }
    
    
    fileprivate let baseView = UIImageView()
    fileprivate let topView = UIImageView()
    fileprivate let foldView = FoldView()
    fileprivate let moreView = [BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView(),
                                BaseView()]
    
}


//MARK: -部署
extension FoldViewController {
    
    
    fileprivate func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        setupBaseView()
        
        setupTopView()
        
        setupFoldView()
        
        
        foldView.getNewImage(FoldModel(topView.image, baseView.image))
    }
    

    
    fileprivate func setupBaseView() {
        
        view.addSubview(baseView)
        
        baseView.image = getImage()
        
        baseView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    fileprivate func setupTopView() {
        view.addSubview(topView)
        
        topView.image = getImage()
        
        topView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    fileprivate func setupFoldView() {
        
        view.addSubview(foldView)
        
        foldView.nextBlock = { [weak self] in
            let lastImage = self?.baseView.image
            self?.topView.image = lastImage
            self?.baseView.image = self?.getImage()
            self?.foldView.getNewImage(FoldModel(lastImage, self?.baseView.image))
        }
        
        foldView.lastBlock = { [weak self] in
            let lastImage = self?.baseView.image
            self?.topView.image = lastImage
            self?.baseView.image = self?.getImage()
            self?.foldView.getNewImage(FoldModel(lastImage, self?.baseView.image))
        }
        
        foldView.hiddenBlock = { [weak self] in
            
            self?.foldView.isHidden = true
            self?.topView.isHidden = false
        }
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panFunc))
        
        view.addGestureRecognizer(pan)
        
    }
}


//MARK: -私有
extension FoldViewController {
    
    
    
    fileprivate func begin() {
        //            ///创建一串view并放置，循环往下翻
        view.isUserInteractionEnabled = false
        index = self.moreView.count
        for eView in self.moreView {
            self.view.addSubview(eView)
            eView.getNewImage(FoldModel(self.getImage1(), self.getImage1()))
        }
        Observable<Int>.interval(0.1, scheduler: MainScheduler.instance).subscribe(
            onNext: {
                print($0)
                self.index -= 1
                print(self.index)
                
                DispatchQueue.main.async {
                    if self.index == 0 {
                        
                        for eView in self.moreView {
                            eView.fuyuan()
                            eView.removeFromSuperview()
                        }
                        self.disposeBag = DisposeBag()
                        self.view.isUserInteractionEnabled = true
                        
                    }
                    
                }
                self.moreView[self.index].anim {
                    self.view.bringSubviewToFront(self.moreView[self.index])
                }
        },
            onDisposed: {})
            .disposed(by: self.disposeBag)
    }
    
    fileprivate func anim() {

    }
    
    @objc fileprivate func panFunc(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            break
        case .possible:
            break
        case .changed:
            if !topView.isHidden {
                topView.isHidden = true
            }
            if foldView.isHidden {
                foldView.isHidden = false
            }
            break
        case .ended:

            break
        case .cancelled:
            break
        case .failed:
            break
        @unknown default:
            break
        }

        foldView.panFunc(pan, { self.view.isUserInteractionEnabled = $0 })
    }
    fileprivate func getImage() -> UIImage? {
        
        let aImage = baseView.image
        var cImage = UIImage(named: "\(arc4random() % 5)")
        
        if aImage != nil {
            if cImage == aImage {
                cImage = getImage()
            }
        }
        
        
        
        return cImage
    }
    fileprivate func getImage1() -> UIImage? {
        
        var cImage = UIImage(named: "\(arc4random() % 5)")
        
        
        return cImage
    }
    
    
    fileprivate func getAnim(_ eview: EspionageView) {
        DispatchQueue.main.async {
           
        }
    }
    
}
