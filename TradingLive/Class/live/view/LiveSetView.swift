
//
//  LiveSetView.swift
//  familyArtwork
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import SnapKit
import NIMSDK
import AntFramework
import Kingfisher
import RxSwift
import NSObject_Rx
import RxDataSources
import MJRefresh

var isHorizontal = false
///整个屏幕宽度
var liveWidth: CGFloat {
    get {
        if isHorizontal {
            return CGFloat.ant.maxScreen
        }
        return CGFloat.ant.minScreen
    }
} // UIScreen.main.applicationFrame.maxX
///整个屏幕高度
var liveHeight: CGFloat {
    get {
        if isHorizontal {
            return CGFloat.ant.minScreen
        }
        return CGFloat.ant.maxScreen
    }
}// UIScreen.main.applicationFrame.maxY
//import UITableView_FDTemplateLayoutCell
class LiveSetView: UIView {

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 11.0, *) {
            directionScroll.contentInsetAdjustmentBehavior = .never
        }
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 滚动到最底部
    fileprivate func scrollToBottom() {

        if imViewModel.messageArr.value.count > 2 {
            guard let indexPath = messageTable.indexPath(for: messageTable.visibleCells[messageTable.visibleCells.count - 1]) else {
                return
            }
            if indexPath.row >= imViewModel.messageArr.value.count - 2 {
                let indexPath = IndexPath(row: imViewModel.messageArr.value.count - 1, section: 0)
                messageTable.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
//    func setShopArr(goodsList: Array<LiveRoomModel.GoodsList>) {
//        for goods in goodsList {
//            shopArr.append(goods)
//            shopCollect.reloadData()
//        }
//    }
    
    
    ///发送消息
    typealias SendNowMessage = (_ message: String)->Void
    var sendNowMessage: SendNowMessage?
    
    typealias BigClick = (_ isBig: Bool)->Void
    var bigClick: BigClick?
    
    
    ///重新加载直播间
    typealias LoadClick = ()->Void
    var loadClick: LoadClick?
    
    ///设置直播间的属性
    typealias MainViewUI = (_ offsetY: CGFloat , _ isUpdata: Bool , _ index: Int)->Void
    var mainViewUI: MainViewUI?
    
    fileprivate let playBtn = UIButton(backImageName: "")
    
    fileprivate let bigBtn = UIButton(backImageName: "zbxqshangpin")
    
    
    fileprivate var isBig = false
    
    
    ///动画view
    fileprivate var animView: NVActivityIndicatorView!
    fileprivate let animText = UILabel(title: "进入直播间...", color: UIColor.white, fontSize: 18, layoutWidth: 0)
    
    ///提示用户重新加载的按钮
    fileprivate let loadBtn = UIButton(title: "点击重试", fontSize: 18, color: UIColor.white, backImageName: "")
    ///搜索栏                          
    fileprivate let searchFiled = UITextField()
    ///控制左右上下的scroll
    fileprivate let directionScroll = UIScrollView()
    ///控制层
    fileprivate let controlView = ResponseView()
    ///加载层
    fileprivate let loadView = UIView()
    ///未开启直播
    fileprivate var liveTitle = UILabel(title: "匠人未开启直播", color: UIColor.white, fontSize: 21, layoutWidth: 0)
    ///上一个主播
    fileprivate let lastView = UIView()
    fileprivate let lastImage = UIImageView(image: UIImage(named: "洛奇背景图"))
    ///模糊view
    fileprivate var lastBlurView: UIVisualEffectView!
    ///下一个主播
    fileprivate let nextView = UIView()
    fileprivate let nextImage = UIImageView(image: UIImage(named: "洛奇背景图"))
    ///下一个主播
    fileprivate var nextBlurView: UIVisualEffectView!
    ///商品层
    fileprivate let shopView = UIView()
    
    ///创建一个模糊效果
    fileprivate let blurEffect = UIBlurEffect(style: .light)
    fileprivate let nextBlurEffect = UIBlurEffect(style: .light)
    fileprivate let scroView = UIView()
    
    ///手势
    fileprivate var pan: UIPanGestureRecognizer!
    fileprivate var absX:CGFloat = 0.0
    ///商品橱窗
    fileprivate var shopCollect: UICollectionView!
    fileprivate let shopLayout = UICollectionViewFlowLayout()
    fileprivate let shopCell = "shopCell"
    ///是否展示
    fileprivate var isShow = false
    ///商品宽高
    fileprivate let collHeight = liveWidth / 3 + 10
    ///是否旋转了页面
    public var isOrient = false
    ///是否在最底部
    fileprivate var currentIsInBottom = false
    //sy_sousuo
    fileprivate let enlargeBtn = UIButton(backImageName: "zbxq_quanping")

    fileprivate var pianyi = 0
    
    let messageTable = loadTableView()
    fileprivate var messageArr = Array<NIMMessage>()
    fileprivate let tableCellId = "LiveMessageCell"
    
    
    
    
    fileprivate let imViewModel = LiveIMViewModel()
    fileprivate var vmOutput : LiveIMViewModel.LXFOutput?
}



//MARK: - 部署
extension LiveSetView: Refreshable {
    
    fileprivate func setupUI() {
        ///添加手势
        pan = UIPanGestureRecognizer(target: self, action: #selector(livePan))
        pan.delegate = self
        addGestureRecognizer(pan)
        
        //添加上下滑动切换
        setupScroll()
        //添加上下视图
        lastAndNext()
        
        directionScroll.setContentOffset(CGPoint(x: 0, y: liveHeight), animated: false)
        
        addSubview(controlView)
        
        controlView.addSubview(bigBtn)
        controlView.addSubview(enlargeBtn)
        addSubview(playBtn)
        setupSearch()
        
        controlView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.height.equalTo(snp.height)
            make.width.equalTo(snp.width)
        }
        enlargeBtn.contentMode = .center
        bigBtn.contentMode = .center
        bigBtn.snp.makeConstraints { (make) in
            make.right.equalTo(controlView.snp.right).offset(-10)
            make.bottom.equalTo(controlView.snp.bottom).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        enlargeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(controlView.snp.right).offset(-10)
            make.bottom.equalTo(bigBtn.snp.top).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        
        
        
        enlargeBtn.addTarget(self, action: #selector(enlarge), for: .touchUpInside)
        bigBtn.addTarget(self, action: #selector(big), for: .touchUpInside)
        
        
        
        ///设置非直播页面属性
        setupLoad()
        setupNoPlay()
        setupStopPlay()
        bringSubviewToFront(controlView)
        setupTable()
        setupShop()
        setupIMViewModel()
        ///控制为加载中页面
        showView(index: 0)
        
        messageTable.mj_header.beginRefreshing()
    }
    
    ///设置商品橱窗
    fileprivate func setupShop() {
        //设置控件的属性
        // 1.设置列间距
        shopLayout.minimumInteritemSpacing = 5
        // 2.设置行间距
        shopLayout.minimumLineSpacing = 5
        // 3.设置每个item的大小
        shopLayout.itemSize = CGSize(width: collHeight - 10, height: collHeight - 10)
        // 5.设置布局方向
        shopLayout.scrollDirection = .vertical
        shopCollect = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: shopLayout)
        shopCollect.delegate = self
        shopCollect.dataSource = self
        shopCollect.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        shopCollect.register(UICollectionViewCell.self, forCellWithReuseIdentifier: shopCell)
        controlView.addSubview(shopCollect)
        shopCollect.snp.makeConstraints { (make) in
            make.left.equalTo(controlView.snp.right)
            make.height.equalTo(liveHeight / 2)
            make.centerY.equalTo(controlView.snp.centerY)
            make.width.equalTo(collHeight)
        }
    }
    ///设置上下切换的scroll
    fileprivate func setupScroll() {
        addSubview(directionScroll)
        directionScroll.isPagingEnabled = true
        directionScroll.scrollsToTop = false
        directionScroll.backgroundColor = UIColor.clear
        directionScroll.contentSize = CGSize(width: liveWidth, height: 3 * liveHeight)
        directionScroll.bounces = false
        directionScroll.showsHorizontalScrollIndicator = false
        directionScroll.showsVerticalScrollIndicator = false
        
        directionScroll.rx.contentOffset
            .subscribe(onNext: { [weak self] contentOffset in
                self?.scrollViewScroll(contentOffset)
            }).disposed(by: rx.disposeBag)
        
        ///即将开始滑动
        directionScroll.rx.willBeginDragging
            .subscribe(onNext: { [weak self] () in
                self?.isOrient = false
                self?.lastView.alpha = 1
                self?.nextView.alpha = 1
            }).disposed(by: rx.disposeBag)
        //停止滑动
        directionScroll.rx.didEndDecelerating
            .subscribe(onNext: { [weak self] in
                self?.scrollEnd()
            }).disposed(by: rx.disposeBag)
        
        //停止滑动
        directionScroll.rx.didEndDragging
            .subscribe(onNext: { [weak self] decelerate in
                if !decelerate {
                    print("这个方法加decelerate判断，只是处理scrollView跟着手指滑动而滑动，手指离开屏幕就停止的情况")
                    self?.scrollEnd()
                }
            }).disposed(by: rx.disposeBag)
        
        
        directionScroll.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
            make.top.equalTo(snp.top)
        }
    }

    
    
    func scrollViewScroll(_ contentOffset: CGPoint) {
        if isOrient {///如果在旋转，并且偏移量等于高才是正确的，否则都是需要显示上下直播间视图
            if contentOffset.y == liveHeight {
                isOrient = false
                lastView.alpha = 0
                nextView.alpha = 0
            }else {
                lastView.alpha = 1
                nextView.alpha = 1
            }
            
        }else {
            lastView.alpha = 1
            nextView.alpha = 1
        }
        mainViewUI?(contentOffset.y, false, 0)
    }
    
    

    ///上下直播间视图
    fileprivate func lastAndNext() {
        directionScroll.addSubview(scroView)
        scroView.addSubview(lastView)
        scroView.addSubview(nextView)
        
        //创建一个承载模糊效果的视图
        lastBlurView = UIVisualEffectView(effect: blurEffect)
        lastView.addSubview(lastImage)
        lastView.addSubview(lastBlurView)
        
        //创建一个承载模糊效果的视图
        nextBlurView = UIVisualEffectView(effect: nextBlurEffect)
        nextView.addSubview(nextImage)
        nextView.addSubview(nextBlurView)
        
        
        
        
        
        
        
        
        
        
        
        
        scroView.snp.makeConstraints { (make) in
            make.left.equalTo(directionScroll.snp.left)
            make.right.equalTo(directionScroll.snp.right)
            make.top.equalTo(directionScroll.snp.top)
            make.bottom.equalTo(directionScroll.snp.bottom)
            make.width.equalTo(directionScroll.snp.width)
            make.height.equalTo(liveHeight * 3)
        }
        lastView.snp.makeConstraints { (make) in
            make.left.equalTo(scroView.snp.left)
            make.right.equalTo(scroView.snp.right)
            make.top.equalTo(scroView.snp.top)
            make.height.equalTo(liveHeight)
        }
        nextView.snp.makeConstraints { (make) in
            make.left.equalTo(scroView.snp.left)
            make.right.equalTo(scroView.snp.right)
            make.bottom.equalTo(scroView.snp.bottom)
            make.height.equalTo(liveHeight)
        }
        
        
        lastImage.snp.makeConstraints { (make) in
            make.left.equalTo(lastView.snp.left)
            make.right.equalTo(lastView.snp.right)
            make.top.equalTo(lastView.snp.top)
            make.bottom.equalTo(lastView.snp.bottom)
            
        }
        lastBlurView.snp.makeConstraints { (make) in
            make.left.equalTo(lastView.snp.left)
            make.right.equalTo(lastView.snp.right)
            make.top.equalTo(lastView.snp.top)
            make.bottom.equalTo(lastView.snp.bottom)
            
        }
        nextImage.snp.makeConstraints { (make) in
            make.left.equalTo(nextView.snp.left)
            make.right.equalTo(nextView.snp.right)
            make.top.equalTo(nextView.snp.top)
            make.bottom.equalTo(nextView.snp.bottom)
            
        }
        nextBlurView.snp.makeConstraints { (make) in
            make.left.equalTo(nextView.snp.left)
            make.right.equalTo(nextView.snp.right)
            make.top.equalTo(nextView.snp.top)
            make.bottom.equalTo(nextView.snp.bottom)
            
        }
        
        
        
    }
    
    ///设置加载中
    fileprivate func setupLoad() {
        animView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .ballScaleRippleMultiple, color: UIColor.white, padding: 5)
        
        controlView.addSubview(animView!)
        controlView.addSubview(animText)
        
        animView!.snp.makeConstraints { (make) in
            make.center.equalTo(controlView.snp.center)
        }
        animText.snp.makeConstraints { (make) in
            make.top.equalTo(animView!.snp.bottom).offset(10)
            make.centerX.equalTo(animView!.snp.centerX)
        }
        //开始动画
        animView.startAnimating()
        
    }
    ///设置未直播
    fileprivate func setupNoPlay() {
        controlView.addSubview(loadBtn)
        controlView.addSubview(liveTitle)
        
        loadBtn.addTarget(self, action: #selector(loadLive), for: .touchUpInside)
        
        
        
        liveTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(controlView.snp.centerX)
            make.centerY.equalTo(controlView.snp.centerY).offset(-15)
        }
        loadBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(controlView.snp.centerX)
            make.top.equalTo(liveTitle.snp.bottom).offset(10)
        }
        
    }
    ///直播已结束
    fileprivate func setupStopPlay() {
        
    }
    
    
    ///设置聊天输入框
    fileprivate func setupSearch() {
        searchFiled.placeholder = "跟主播聊天吧！"
        searchFiled.inputAccessoryView = UIView()
        searchFiled.placeholderColor = UIColor.white
        
        searchFiled.borderStyle = .none
        searchFiled.backgroundColor = UIColor.clear
        searchFiled.returnKeyType = .send
        searchFiled.delegate = self
        let left = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 35))
        searchFiled.leftView = left
        searchFiled.leftViewMode = .always
        searchFiled.clearButtonMode = .always
        searchFiled.textColor = UIColor.white
        
        controlView.addSubview(searchFiled)
        searchFiled.layer.cornerRadius = 17
        searchFiled.layer.masksToBounds = true
        searchFiled.layer.borderWidth = 1
        searchFiled.layer.borderColor = UIColor.gray.cgColor
        
        searchFiled.snp.makeConstraints { (make) in
            make.left.equalTo(controlView.snp.left).offset(10)
            make.bottom.equalTo(controlView.snp.bottom).offset(-10)
            make.height.equalTo(35)
            make.right.equalTo(controlView.snp.right).offset(-60)
        }
    }
    
    ///设置聊天table
    fileprivate func setupTable() {
        controlView.addSubview(messageTable)
        // 设置代理
        messageTable.rx.setDelegate(self).disposed(by: rx.disposeBag)
        messageTable.register(LiveMessageCell.self, forCellReuseIdentifier: "LiveMessageCell")
        messageTable.backgroundColor = UIColor.clear
        messageTable.separatorStyle = .none
        messageTable.estimatedRowHeight = 44.0
        messageTable.rowHeight = UITableView.automaticDimension

        messageTable.reloadSuccess = { [weak self] in
            self?.scrollToBottom()
        }
        messageTable.snp.makeConstraints { (make) in
            make.left.equalTo(searchFiled.snp.left)
            make.bottom.equalTo(searchFiled.snp.top)
            make.top.equalTo(controlView.snp.centerY).offset(liveWidth / 2 / 3)
            make.right.equalTo(searchFiled.snp.right)
        }
        
        
        

    }
    

    
    fileprivate func setupIMViewModel() {
        
        let vmInput = LiveIMViewModel.LXFInput()
        let vmOutput = imViewModel.transform(input: vmInput)
        
        
 
        
        let dataSource = RxTableViewSectionedReloadDataSource<LiveIMSection>(configureCell: { [weak self] ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: "LiveMessageCell") as! LiveMessageCell
            cell.selectionStyle = .none
            if let message = self?.imViewModel.messageArr.value[ip.row] {
                cell.setupCellUI(message: message)
     
            }
            
            //            cell.picView.kf.setImage(with: URL(string: item.url))
            //            cell.descLabel.text = "描述: \(item.desc)"
            //            cell.sourceLabel.text = "来源: \(item.source)"
            return cell
        })
        vmOutput.sections.asDriver().drive(messageTable.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        vmOutput.refreshStatus.asObservable().subscribe(onNext: { [weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.messageTable.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.messageTable.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.messageTable.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.messageTable.mj_footer.endRefreshing()
            case .noMoreData:
                self?.messageTable.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: rx.disposeBag)
        
        
        // 设置下拉刷新
        let header = initRefreshHeader(messageTable, onlyAnim: true, { [weak self] in
            vmOutput.requestCommond.onNext(true)
        })
        messageTable.mj_header = header
        
        vmOutput.autoSetRefreshHeaderStatus(header: messageTable.mj_header, footer: nil).disposed(by: rx.disposeBag)
    }
    

}

class loadTableView: UITableView {
    override func reloadData() {
        super.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.reloadSuccess?()
        }
        
    }
    
    var reloadSuccess: (()->())?
    

}
//MARK: - 公共方法
extension LiveSetView {
    
    public func updateUI() {
        imViewModel.loadChatRoom()
    }

    
    
    public func updateUI(_ isH: Bool) {
        
        lastView.alpha = 0
        nextView.alpha = 0
        isOrient = true
        isHorizontal = isH
        isBig = isH
        
        ///修改直播控制页面的各个位置
        scroView.snp.updateConstraints { (make) in
            make.height.equalTo(liveHeight * 3)
        }
        lastView.snp.updateConstraints { (make) in
            make.height.equalTo(liveHeight)
        }
        nextView.snp.updateConstraints { (make) in
            make.height.equalTo(liveHeight)
        }
        //修改滑动属性
        directionScroll.contentSize = CGSize(width: liveWidth, height: liveHeight * 3)
        directionScroll.setContentOffset(CGPoint(x: 0, y: liveHeight), animated: false)
        ///修复橱窗位置
        if isShow {
            isShow = true
            shopCollect.snp.updateConstraints { (make) in
                make.left.equalTo(controlView.snp.right).offset(-(collHeight))
            }
        }else{
            isShow = false
            shopCollect.snp.updateConstraints { (make) in
                make.left.equalTo(controlView.snp.right)
            }
        }
        
        
    }
    
    
    public func updateImage(_ last: String, next: String) {
        lastImage.kf.setImage(with: URL(string: last), placeholder: UIImage(named: "洛奇背景图"))
        nextImage.kf.setImage(with: URL(string: next), placeholder: UIImage(named: "洛奇背景图"))
    }
    
    public func updateControl(_ offset: CGFloat) {
        
        controlView.snp.updateConstraints({ (make) in
            make.top.equalTo(snp.top).offset(offset)
        })
    }
    
    
    public func updateScroll(_ isScrollEnabled: Bool) {
        directionScroll.isScrollEnabled = isScrollEnabled
    }
}

//MARK: - 控制
extension LiveSetView {
    ///设置非播放页面的数据
    ///0 加载中   1  未播放   2  播放结束   3   关闭非播放页面   4  播放异常
    public func showView(index: Int) {
        switch index {
        case 0:
            animView.alpha = 1
            animText.alpha = 1
            loadBtn.alpha = 0
            liveTitle.alpha = 0
            animView.startAnimating()
            return
        case 1:
            animView.alpha = 0
            animText.alpha = 0
            loadBtn.alpha = 1
            liveTitle.alpha = 1
            liveTitle.text = "匠人未开启直播"
            break
        case 2:
            animView.alpha = 0
            animText.alpha = 0
            loadBtn.alpha = 1
            liveTitle.alpha = 1
            liveTitle.text = "直播已经结束"
            break
        case 3:
            animView.alpha = 0
            animText.alpha = 0
            loadBtn.alpha = 0
            liveTitle.alpha = 0
            break
        case 4:
            animView.alpha = 0
            animText.alpha = 0
            loadBtn.alpha = 1
            liveTitle.alpha = 1
            liveTitle.text = "播放异常请重试"
            break
        default:
            break
        }
        animView.stopAnimating()
        
    }
}

//MARK: - 点击事件
extension LiveSetView {
    
    
    @objc fileprivate func loadLive() {
        showView(index: 0)
        loadClick?()
    }
    
    
    @objc fileprivate func big() {
        
        if isShow {
            commitTranslation(translation: CGPoint(x: collHeight, y: 0))
            stopShow(translation: CGPoint(x: collHeight, y: 0))
        }else {
            commitTranslation(translation: CGPoint(x: -collHeight, y: 0))
            stopShow(translation: CGPoint(x: -collHeight, y: 0))
        }
        
    }
    
    @objc fileprivate func enlarge() {
        bigClick?(isBig)
        
        
    }
}

//MARK: - tableView代理
extension LiveSetView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messageArr.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as? LiveMessageCell
//        cell?.setupCellUI(message: messageArr[indexPath.row])
//        cell?.selectionStyle = .none
//        return cell!
//    }
//
//}
//MARK: - 键盘代理
extension LiveSetView: UITextFieldDelegate{
    ///发送消息按钮
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text as Any)
        if let message = textField.text {
            if message.count != 0 {
                sendNowMessage?(message)
                imViewModel.sendMessage(message: message)
                textField.text = ""
            }
        }

        return true
    }
    
}

//MARK: - UIScrollView
extension LiveSetView{
    
 
    
    fileprivate func scrollEnd() {
        

        
        lastView.alpha = 0
        nextView.alpha = 0
        let offset = directionScroll.contentOffset.y
        if offset == liveHeight {
            mainViewUI?(liveHeight , false, 0)
        }else {
            if offset > liveHeight {
                mainViewUI?(liveHeight , true, 1)
                
            }else {
                
                mainViewUI?(liveHeight , true, -1)
                
            }
            
            
        }
        directionScroll.setContentOffset(CGPoint(x: 0, y: liveHeight), animated: false)
    }
}

//MARK: -  UICollectionView代理
extension LiveSetView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopCell, for: indexPath) as! UICollectionViewCell
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UICollectionViewCell
        
    }
}

//MARK: - 手势
extension LiveSetView: UIGestureRecognizerDelegate {
    
    /**
     *  平移手势响应事件
     *
     *  @param swipe swipe description
     */
    @objc func livePan(pan: UIPanGestureRecognizer) {
        if pan.state == .changed {
            commitTranslation(translation: pan.translation(in: self))
        }
        if pan.state == .ended {
            stopShow(translation: pan.translation(in: self))
        }
    }
    /**
     *   判断手势方向
     *
     *  @param translation translation description
     */
    func commitTranslation(translation: CGPoint){
    
        absX = fabs(translation.x);
       
        var rua: Int = 0
        let abs = Int(absX)
        print(absX)
        if translation.x < 0{
            //左滑
            if !isShow {//没有展示
                rua = abs
            }else {//展示后的处理
                rua = pianyi + abs
            }
            
        }else {
            //右
            if !isShow {//没有展示
                rua = -abs
            }else {//展示后的处理
                rua = pianyi - abs
                
            }
        }
        if rua > Int(collHeight) + 20 {
            rua = Int(collHeight) + 20
        }else if rua < -20 {
            rua = -20
        }
        shopCollect.snp.updateConstraints { (make) in
            make.left.equalTo(controlView.snp.right).offset(-rua)
        }
        
    
    
    }
    ///手势结束后调用
    func stopShow(translation: CGPoint) {
        print(translation.x)
        //需要展示橱窗
        if !isShow && translation.x < 0{
             if absX > collHeight / 2 {//超过某个位置就全部展示
                isShow = true
                shopCollect.snp.updateConstraints { (make) in
                    make.left.equalTo(controlView.snp.right).offset(-(collHeight))
                }
                
             }else {//未超过，回归原位
                isShow = false
                shopCollect.snp.updateConstraints { (make) in
                    make.left.equalTo(controlView.snp.right)
                }
            }
        }else if isShow && translation.x > 0{
            //取消展示橱窗
            if absX > collHeight / 2 { //超过某个位置就回归原位
                isShow = false
                shopCollect.snp.updateConstraints { (make) in
                    make.left.equalTo(controlView.snp.right)
                }
            }else {//未超过，继续展示
                isShow = true
                shopCollect.snp.updateConstraints { (make) in
                    make.left.equalTo(controlView.snp.right).offset(-(collHeight))
                }
            }

            
        }else if isShow && translation.x < 0 {//已经展示但是还向左滑动了,继续展示
            isShow = true
            shopCollect.snp.updateConstraints { (make) in
                make.left.equalTo(controlView.snp.right).offset(-(collHeight))
            }
        }else if !isShow && translation.x > 0 {//未展示但是还是向右滑动,继续取消展示
            isShow = false
            shopCollect.snp.updateConstraints { (make) in
                make.left.equalTo(controlView.snp.right)
            }
        }
       
        if isShow {
            pianyi = Int(collHeight)
        }else {
            pianyi = 0
        }

       print(isShow)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
        
    }

}

