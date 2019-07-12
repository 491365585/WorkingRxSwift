//
//  LiveMessageCell.swift
//  familyArtwork
//
//  Created by mac on 2018/12/8.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import SDWebImage
import NIMSDK
//import SDAutoLayout

class LiveMessageCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func setupCell() {
        addSubview(backView)
        addSubview(content)
        
        
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = liveWidth - 70

        backView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
      
        content.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(0)
        }

        
    }
    
    func setupCellUI(message: NIMMessage) {
        
        var nameText = ""
        if message.senderName != nil {
            nameText = message.senderName!
        }else {
            nameText = ""
            if message.from != "" {
                nameText = message.from ?? ""
            }
        }
        if message.isOutgoingMsg {
            nameText = "我"
        }else {
        }
        //content.text =  (message.text ?? "")
        
        //定义富文本即有格式的字符串
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString(string: "")
        attributedStrM.yy_font = UIFont.ant.regular(13)
        if nameText != "" {
            nameText = " " + nameText + ":"
            let oneName = NSMutableAttributedString(string: nameText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue, NSAttributedString.Key.font : UIFont.ant.regular(13)])
            
            
            
            oneName.yy_setTextHighlight(NSRange(location: 0, length: nameText.count), color: UIColor.hexColor("b0e6fe"), backgroundColor: UIColor.clear) { [weak self] (containerView, text, range, rect) in
                print("点击了" + nameText)
                
            }
            
            attributedStrM.append(oneName)
            
        }
        
        if message.text != "" {
            let messageText = " " + message.text! + " "
            
            let twoTitle = NSMutableAttributedString(string: messageText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.ant.regular(13)])
            
            attributedStrM.append(twoTitle)
            
        }
//        YYTextBorder * border = [YYTextBorder borderWithFillColor:XXColor cornerRadius:XX];    //创建背景色（颜色与圆角）
//        border.insets=UIEdgeInsetsMake(0,0,0,0);        //背景色的偏移量
//        [str setYy_textBackgroundBorder:border];
//
//
        let border = YYTextBorder(fill: UIColor(white: 0.5, alpha: 0.5), cornerRadius: 0)
        border.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        attributedStrM.yy_setTextBackgroundBorder(border, range: NSRange(location: 0, length: attributedStrM.string.count))
        content.attributedText = attributedStrM
        
        
        
        
//        let url = URL(string: message.)
//        SDWebImageManager.shared().loadImage(with: url, options: SDWebImageOptions.highPriority, progress: nil) { (image, data, error, _, _, _) in
//            if error != nil {
//                print("\(String(describing: error))")
//            }else {
//                self.icon.image = image
//
//            }
//        }

        
    }
    
    
    let backView = UIView()
    let icon = UIImageView()
    let content = YYLabel()
}
