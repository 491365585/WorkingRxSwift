//
//  Ant+Date.swift
//  AntWorkBox_Swift
//
//  Created by 马义飞 on 2017/11/23.
//

import Foundation

public class AntClassDate {
    
    public func dateDifference(_ formatter: String, beginStr: String, endStr: String) -> TimeInterval? {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = formatter
        
        guard let beginDate = dateFormatter.date(from: beginStr) else {
            return nil
        }
        
        guard var endDate = dateFormatter.date(from: endStr) else {
            return nil
        }
        
        if beginDate > endDate {
            endDate = endDate.addingTimeInterval(60 * 60 * 24)
        }
        
        return endDate.timeIntervalSince(beginDate)
    }
}

public class AntObjectDate {
    
    let value: Date
    
    init(_ value: Date) {
        self.value = value
    }
    
    /// 格式化为默认日期字符串
    ///
    /// - Returns: 字符串
    public func string() -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: value)
    }
    
    
    /// 根据传入的字符串，格式化为对应的日期
    ///
    /// - Parameter dateFormat: 字符串 y-年 M-月 d-日 H-时 m-分 s-秒
    /// - Returns: 字符串
    public func string(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: value)
    }
    
    /// 根据当前Date，获取周几
    ///
    /// - Returns: 1-周日 7-周六
    public func weekDay() -> Int {
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        return calendar.component(Calendar.Component.weekday, from: self.value)
    }
    
    /// 根据当前Date，获取本月天数
    public func monthDays() -> Int {
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self.value)
        return range?.length ?? 30
    }
    
    /// 某天的后一天
    public func nextDay() -> Date {
        return Date.init(timeIntervalSince1970: self.value.timeIntervalSince1970 + 24 * 60 * 60)
    }
    
    /// 某天的后N天
    public func nextDay(_ number: Int) -> Date {
        return Date.init(timeIntervalSince1970: self.value.timeIntervalSince1970 + 24 * 60 * 60 * Double(number))
    }
    
    /// 某天的下N个月
    public func nextMonth(_ number: Int) -> Date {
        guard var year = Int(self.value.ant.string("yyyy")) else {
            return self.value
        }
        guard var month = Int(self.value.ant.string("MM")) else {
            return self.value
        }
        year = year + (month + number) / 12
        month = (month + number) % 12
        if month == 0 {
            month = 12
        }
        guard let date = "\(year)-\(month < 10 ? "0\(month)" : "\(month)")".ant.date("yyyy-MM") else {
            return self.value
        }
        return date
    }
    
    /// 一周开始日期（星期天）
    public func startOfThisWeek() -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.yearForWeekOfYear, .weekOfYear]), from: self.value)
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek
    }
    
    /// 一月开始日期
    public func startOfThisMonth() -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]), from: self.value)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    /// 根据当前Date，获取周几
    ///
    /// - Parameter title: 比如“星期”，“周”
    /// - Returns: 比如“星期一”，“周二”
    public func weekDayStr(_ title: String) -> String {
        switch self.weekDay() {
        case 1:
            return "\(title)日"
        case 2:
            return "\(title)一"
        case 3:
            return "\(title)二"
        case 4:
            return "\(title)三"
        case 5:
            return "\(title)四"
        case 6:
            return "\(title)五"
        case 7:
            return "\(title)六"
        default:
            return "\(title)日"
        }
    }
}

extension Date {
    
    public static var ant: AntClassDate {
        return AntClassDate.init()
    }
    
    public var ant: AntObjectDate {
        return AntObjectDate.init(self)
    }
}
