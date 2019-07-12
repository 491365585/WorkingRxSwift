//
//  StringCalculateManager.swift
//  SohuAuto
//
//  Created by ruiwendaier on 2018/12/5.
//  Copyright © 2018年 auto. All rights reserved.
//

import Foundation
import UIKit

class StringCalculateManager {
    static let shared = StringCalculateManager()
    //fontDictionary是一个Dictionary，例如{".SFUIText-Semibold-16.0": {"0":10.3203125, "Z":10.4140625, "中":16.32, "singleLineHeight":19.09375}}，
    //fontDictionary的key是以字体的名字和大小拼接的String，例如".SFUIText-Semibold-16.0"
    //fontDictionary的value是一个Dictionary，存储对应字体的各种字符对应的宽度及字体的单行高度，例如{"0":10.3203125, "Z":10.4140625, "中":16.32, "singleLineHeight":19.09375}
    var fontDictionary = [String: [String: CGFloat]]()
    var numsNeedToSave = 0//更新的数据的条数
    var fileUrl: URL = {//fontDictionary在磁盘中的存储路径
        let manager = FileManager.default
        var filePath = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        filePath!.appendPathComponent("font_dictionary.json")
//        print("font_dictionary.json的路径是===\(filePath!)")
        return filePath!
    }()
    
    init() {
        readFontDictionaryFromDisk()
        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: UIApplication.willTerminateNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //第一次使用字体时预先计算该字体中各种字符的宽度
    func createNewFont(font: UIFont, size: CGSize) -> [String: CGFloat] {
        let array: [String] = ["中", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",  "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e",  "f",  "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "“", ";", "？", ",", "［", "]", "、", "【", "】", "?", "!", ":", "|"]
        var widthDictionary = [String: CGFloat]()
        var singleWordRect = CGRect.zero
        for string in array { //usesLineFragmentOrigin
            var options = NSStringDrawingOptions()
            options = [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading]
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2//lineSpacing
            let attributes = [NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : paragraphStyle]
            singleWordRect = string.boundingRect(with: CGSize(width: size.width, height: CGFloat(MAXFLOAT)), options: options, attributes: attributes, context: nil)
            /// 记录每个字符的宽度
            widthDictionary[string] = singleWordRect.size.width
        }
        /*
         - key : "singleLineHeight"
         - value : 22.4
         */
        /// 记录字符的高度: 字符的高度是不变的
        widthDictionary["singleLineHeight"] = singleWordRect.size.height
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        fontDictionary[fontKey] = widthDictionary
        numsNeedToSave = array.count//代表有更新，需要存入到磁盘
        saveFontDictionaryToDisk()//存入本地json
        return widthDictionary
    }
    
    
    /// 计算Label的bounds
    func calculateSize(withString string: String, size: CGSize, font: UIFont, numberOfLines: Int) -> CGRect {
        var widthDictionary = [String: CGFloat]()
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        if let dictionary =  StringCalculateManager.shared.fontDictionary[fontKey] {
            widthDictionary = dictionary
        } else {
            widthDictionary = StringCalculateManager.shared.createNewFont(font: font, size: size)
        }
        
        /// 总宽度
        var totalWidth: CGFloat = 0
        /// 默认取中文字符宽度
        let chineseWidth = widthDictionary["中"]!
        print("\(string)")
        for character in string {
            //print("\(character)")
            if "\u{4E00}" <= character  && character <= "\u{9FA5}" {//中文
                totalWidth += chineseWidth
            } else if let width = widthDictionary[String(character)]  {//数字，小写字母，大写字母，及常见符号
                totalWidth += width
            } else {//符号及其他没有预先计算好的字符，对它们进行计算并且缓存到宽度字典中去
                let tempString = String(character)
                let width = tempString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                    options: .usesFontLeading,
                                                    attributes: [NSAttributedString.Key.font: font],
                                                    context: nil).size.width
                totalWidth += width
                widthDictionary[tempString] = width
                numsNeedToSave += 1
            }
        }
        
        /// 更新内存缓存的 字体宽度字典
        fontDictionary[fontKey] = widthDictionary
        
        if numsNeedToSave > 10 {
            saveFontDictionaryToDisk()
        }
        
        /// 单行高度
        let singleLineHeight = widthDictionary["singleLineHeight"]!
        
        /// 行数
        var tempNumsOfLine = 0
        
        if numberOfLines == 0{
            /// 传进来的行数为0, 代表不限行
            let line = Int(ceil(totalWidth / size.width))
            tempNumsOfLine = line
        }else{
            /// 传进来的行数不为0, 代表限行
            let line = Int(ceil(totalWidth / size.width))
            tempNumsOfLine = (line <= numberOfLines) ? line : numberOfLines
        }
        
        /// 计算出来的宽度
        let resultwidth = tempNumsOfLine <= 1 ? totalWidth : size.width /// 小于最大宽度时，取实际宽度的值
        
        /// 计算出来的高度
        let resultHeight = (singleLineHeight * CGFloat(tempNumsOfLine)) > size.height ? size.height: (singleLineHeight * CGFloat(tempNumsOfLine)) /// 计算结果超出最大高度时，取最大高度的值
        
        return CGRect.init(x: 0, y: 0, width: resultwidth, height: resultHeight)
    }
    
    let queue = DispatchQueue(label: "com.StringCalculateManager.queue")
    //存储fontDictionary到磁盘
    @objc func saveFontDictionaryToDisk() {
        guard numsNeedToSave > 0 else {
            return
        }
        numsNeedToSave = 0
        queue.async {//防止多线程同时写入造成冲突
            do {
                var data: Data?
                if #available(iOS 11.0, *) {
                    data = try? JSONSerialization.data(withJSONObject: self.fontDictionary, options: .sortedKeys)
                } else {
                    data = try? JSONSerialization.data(withJSONObject: self.fontDictionary, options: .prettyPrinted)
                }
                try data?.write(to: self.fileUrl)
                print("font_dictionary存入磁盘,font_dictionary=\(self.fontDictionary)")
            }  catch {
                print("font_dictionary存储失败error=\(error)")
            }
        }
    }
    //从磁盘中读取缓存
    func readFontDictionaryFromDisk() {
        do {
            let data = try Data.init(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let dict = json as? [String: [String: CGFloat]] else {
                return
            }
            fontDictionary = dict
            /// print("font_dictionarys读取成功,font_dictionarys=\(fontDictionary)")
        } catch {
            print("磁盘中不存在font_dictionary.json文件或读取失败")
        }
    }
}

extension String {
    public func boundingRectFast(withMaxSize size: CGSize, font: UIFont, numberOfLines: Int) -> CGRect {
        let rect = StringCalculateManager.shared.calculateSize(withString: self, size: size, font: font, numberOfLines: numberOfLines)
        return rect
    }
}
