//
//  Ant+String.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2017/11/23.
//

import Foundation
import UIKit

public class AntClassString {
   
}

public class AntObjectString {
    
    let value: String
    
    var fontDictionary = [String: [String: CGFloat]]()
    var numsNeedToSave = 0//更新的数据的条数
    var fileUrl: URL = {//fontDictionary在磁盘中的存储路径
        let manager = FileManager.default
        var filePath = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        filePath!.appendPathComponent("font_dictionary.json")
        //        print("font_dictionary.json的路径是===\(filePath!)")
        return filePath!
    }()
    
    init(_ value: String) {
        self.value = value
//        readFontDictionaryFromDisk()
//        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
    }
    
    public func jsonDict() -> [String: Any]? {
        if let data = self.value.data(using: String.Encoding.utf8) {
            if let dict = data.ant.jsonDict() {
                return dict
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public func jsonArray() -> [Any]? {
        if let data = self.value.data(using: String.Encoding.utf8) {
            if let array = data.ant.jsonArray() {
                return array
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    /// 获取字符串所占Size
    ///
    /// - Parameter font: Font
    /// - Returns: CGFloat
    public func size(_ font: UIFont) -> CGSize {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
        label.font = font
        label.text = value
        label.numberOfLines = 1
        label.sizeToFit()
        return label.frame.size
    }
    
    /// 获取字符串所占宽度
    ///
    /// - Parameter font: Font
    /// - Returns: CGFloat
    public func width(_ font: UIFont) -> CGFloat {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
        label.font = font
        label.text = value
        label.numberOfLines = 1
        label.sizeToFit()
        return label.frame.size.width
    }
    
    /// 获取字符串所占宽度
    ///
    /// - Parameter font: Font
    /// - Returns: CGFloat
    public func width(_ font: UIFont, width: CGFloat, offset: CGFloat) -> CGFloat {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
        label.font = font
        label.text = value
        label.numberOfLines = 1
        label.sizeToFit()
        return label.frame.size.width + offset > width ? width : label.frame.size.width + offset
    }
    
    /// 获取字符串所占高度
    ///
    /// - Parameter font: Font
    /// - Returns: CGFloat
    public func height(_ font: UIFont, width: CGFloat, line: Int = 0) -> CGFloat {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 1))
        label.font = font
        label.text = value
        label.numberOfLines = line
        label.sizeToFit()
        return label.frame.size.height
    }
    
    ///计算多行文本的高度
    public func heightWithLabelFont(font: UIFont, width: CGFloat, lineSpacing: CGFloat = 0.0) -> CGFloat {
        var height:CGFloat = 0.0
        
        if value.count == 0 {
            height = 0.0
        } else {
            var options = NSStringDrawingOptions()
            options = [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading]
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            let attributes = [NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : paragraphStyle]
            
            //计算文本高度,文本有多行
            let rectSize = value.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, attributes: attributes, context: nil).size
            height = rectSize.height
        }
        return height
    }
    
    
    /// 清除字符串里面的换行符
    ///
    /// - Returns: 字符串
    public func clearEnter() -> String {
        let titles: NSArray = value.components(separatedBy: "\n") as NSArray
        let title = titles.componentsJoined(by: " ")
        let subTitles: NSArray = title.components(separatedBy: "\r") as NSArray
        let subTitle = subTitles.componentsJoined(by: " ")
        return subTitle
    }
    
    /// 清除字符串里面的换行符
    ///
    /// - Returns: 字符串
    public func clearEnterAndSpace() -> String {
        let titles01: NSArray = value.components(separatedBy: "\n") as NSArray
        let title01 = titles01.componentsJoined(by: "")
        let titles02: NSArray = title01.components(separatedBy: "\r") as NSArray
        let title02 = titles02.componentsJoined(by: "")
        let titles03: NSArray = title02.components(separatedBy: " ") as NSArray
        let title03 = titles03.componentsJoined(by: "")
        return title03
    }
    
    /// 打印当前字符串
    public func debugPrint() {
        Swift.debugPrint(value)
    }
    
    public func intStr() -> String {
        if let number = Int(self.value) {
            return "\(number)"
        } else {
            return "0"
        }
    }
    
    public func floatStr(roundNum: Int) -> String {
        var number: CGFloat = 0
        if let subNumber = Float(self.value) {
            number = CGFloat(subNumber)
        }
        number = number.ant.round(roundNum)
        
        let str = "%.\(roundNum)f"
        return NSString.init(format: str as NSString, number) as String
    }
    
    /// 根据DateFormat获取日期
    ///
    /// - Parameter dateFormat: DateFormat
    /// - Returns: Date
    public func date(_ dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self.value)
    }
    
    /// 根据"yyyy-MM-dd HH:mm:ss"获取日期
    ///
    /// - Parameter dateFormat: DateFormat
    /// - Returns: Date
    public func dateNormal() -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self.value)
    }
    
    /// 根据"yyyy-MM-dd"获取日期
    ///
    /// - Parameter dateFormat: DateFormat
    /// - Returns: Date
    public func dateSeven() -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self.value)
    }
    /// 是否只包含数字和小数点
    ///
    /// - Returns: true-只包含数字，false-除了数字小数点还有其他
    public func onleNumberAndPoint() -> Bool {
        var onleNumber = true
        for char in value {
            switch char {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".":
                break
            default:
                onleNumber = false
            }
        }
        return onleNumber
    }
    
    /// 是否只包含数字
    ///
    /// - Returns: true-只包含数字，false-除了数字小数点还有其他
    public func onleNumber() -> Bool {
        var onleNumber = true
        for char in value {
            switch char {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                break
            default:
                onleNumber = false
            }
        }
        return onleNumber
    }
    
    /// 如果==某个值，就返回另一个值
    ///
    /// - Parameters:
    ///   - ifStr: 某个值
    ///   - toStr: 另一个值
    /// - Returns: String
    public func ifTo(_ ifStr: String, toStr: String) -> String {
        if self.value == ifStr {
            return toStr
        } else {
            return self.value
        }
    }
    
    /// 如果==某个值，就返回另一个值
    ///
    /// - Parameters:
    ///   - ifDouble: 某个值
    ///   - toStr: 另一个值
    /// - Returns: String
    public func ifTo(_ ifDouble: Double, toStr: String) -> String {
        if let double = Double(self.value) {
            if double == ifDouble {
                return toStr
            } else {
                return self.value
            }
        } else {
            return self.value
        }
    }
    
    
    ///判断如果包含中文
    public func containChinese(str: String) -> Bool {
        
        for i in 0..<str.count {
            let a = (str as NSString).character(at: i)
            if a > 0x4e00 && a < 0x9fff {
                return true
            }
        }
        return false
    }
    
    /// 分割字符串
    public func separatedString() -> String? {
        if let range = getRange() {
            //截取=后字符(不包含=)
            let backString : String = String(self.value.suffix(from: range.upperBound))
            return backString
        }
        return nil
    }
    
    /// 分割字符串,音频type
    public func separatedAudioType() -> String? {
            //截取=后字符(不包含=)
        if let range = self.value.range(of: "&type=") {

            let backString : String = String(self.value.suffix(from: range.upperBound))
            return backString
        }
        return nil
    }
    
    /// 分割字符串,音频id
    public func separatedAudioId() -> String? {
        
        if let _ = value.range(of: "&") {
            let i = value.index(value.startIndex, offsetBy: positionOf(value, sub: "&"))
            
            return String(value.substring(to: i))
            
        }
        
        return nil
    }
    
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(_ str: String, sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = str.range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = str.distance(from: str.startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    /// 字符串转十进制
    public func strTo10() -> String {
        
        if self.value.isEmpty {
            return ""
        }
        
        let map = [
            "a":51, "b":49, "c":47, "d":45, "e":43, "f":41, "g":39, "h":37, "i":35, "j":33,
            "k":31, "l":29, "m":27, "n":25, "o":23, "p":21, "q":19, "r":17, "s":15, "t":13,
            "u":11, "v":9, "w":7, "x":5, "y":3, "z":1, "A":0, "B":2, "C":4, "D":6, "E":8,
            "F":10, "G":12, "H":14, "I":16, "J":18, "K":20, "L":22, "M":24, "N":26,
            "O":28, "P":30, "Q":32, "R":34, "S":36, "T":38, "U":40, "V":42, "W":44, "X":46,
            "Y":48, "Z":50, "0":63, "1":54, "2":59, "3":55, "4":60, "5":56, "6":61, "7":57,
            "8":62, "9":58, "_":52, "=":53
        ]
        
        var dec = 0
        
        var stringArray = [String].init()
        for char in self.value {
            print(char)
            
            stringArray.append(String(char))
        }
        
        let lenth = stringArray.count
        
        for i in 0..<lenth {
            let key = stringArray[i]
            
            guard let value : Int = map[key] else{
                return ""
            }
            
            let j = lenth - i - 1
            // $dec += ($j == 0 ? $b : (2 << (6 * $j - 1)) * $b);
            dec += (j == 0 ? value : (2 << (6 * j - 1)) * value);
        }
        return String(dec)
    }
    
    
    public func getRange() -> Range<String.Index>? {
        if let range = self.value.range(of: "articleId=") {
            return range
        }
        if let range = self.value.range(of: "audioId=") {
            return range
        }
        if let range = self.value.range(of: "bulletinId=") {
            return range
        }
        if let range = self.value.range(of: "strategyId=") {
            return range
        }
        if let range = self.value.range(of: "videoId=") {
            return range
        }
        if let range = self.value.range(of: "viewId=") {
            return range
        }
        if let range = self.value.range(of: "userId=") {
            return range
        }
//        if let range = self.value.range(of: "openApp=") {
//            return range
//        }
        return nil
    }
    ///0是公告，1是视频，2是音频，3是个人动态，4是专栏，5是策略， 6是用户
    public func getType() -> Int? {
        if let _ = self.value.range(of: "articleId=") {
            return 4
        }
        if let _ = self.value.range(of: "audioId=") {
            return 2
        }
        if let _ = self.value.range(of: "bulletinId=") {
            return 0
        }
        if let _ = self.value.range(of: "strategyId=") {
            return 5
        }
        if let _ = self.value.range(of: "videoId=") {
            return 1
        }
        if let _ = self.value.range(of: "viewId=") {
            return 3
        }
        if let _ = self.value.range(of: "userId=") {
            return 6
        }
        //        if let range = self.value.range(of: "openApp=") {
        //            return range
        //        }
        return nil
    }
    
    //根据开始位置和长度截取字符串
    public func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.value.count - start
        }
        let st = self.value.index(self.value.startIndex, offsetBy: start)
        let en = self.value.index(st, offsetBy:len)
        return String(self.value[st ..< en])
    }
    
}

extension String {
    
    public static var ant: AntClassString {
        return AntClassString.init()
    }
    
    public var ant: AntObjectString {
        return AntObjectString.init(self)
    }
}

extension NSString {
    
    public static var ant: AntClassString {
        return AntClassString.init()
    }
    
    public var ant: AntObjectString {
        return AntObjectString.init(self as String)
    }
}



















