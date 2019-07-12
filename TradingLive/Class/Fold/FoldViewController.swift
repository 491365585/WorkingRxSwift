//
//  FoldViewController.swift
//  TradingLive
//
//  Created by Anthony on 2019/7/4.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation
import RongJinFramework

class FoldViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        for e in moreView {
            e.setupTop()
        }
        let button = UIButton(frame: CGRect(x: 10, y: 30, width: 50, height: 25))
        button.setTitle("返回", for: .normal)
        button.rx.tap.subscribe { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        view.addSubview(button)
        let button1 = UIButton(frame: CGRect(x: mainWidth - 60, y: 30, width: 50, height: 25))
        button1.setTitle("首页", for: .normal)
        button1.rx.tap.subscribe { [weak self] (_) in
            guard let self = self else {
                return
            }
            ///创建一串view并放置，循环往下翻
            for eView in self.moreView {
                self.view.addSubview(eView)
                eView.setupTop()
                let a = FoldModel(self.getImage1(), self.getImage1())
                eView.getBackImage(a.topImage)
                eView.getPositiveImage(a.topBackImage)
            }
            
            self.getAnim(self.moreView.count - 1)
            
        }
        
        view.addSubview(button1)
    }
    
    
    fileprivate let baseView = UIImageView()
    fileprivate let topView = UIImageView()
    fileprivate let foldView = FoldView()
    fileprivate let moreView = [EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)),
                                EspionageView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight))]
    
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

        foldView.panFunc(pan)
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
    
    
    fileprivate func getAnim(_ index: Int) {
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else {
                return
            }
            self.moreView[index].layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(Double.pi), 1, 0, 0)
        }, completion: { [weak self] (_) in
            guard let self = self else {
                return
            }
            guard index - 1 <= -1 else {
                for eView in self.moreView {
                    eView.layer.transform = CATransform3DIdentity
                    eView.removeFromSuperview()
                }
                return
            }
            self.getAnim(index - 1)
        })
    }
    
}
