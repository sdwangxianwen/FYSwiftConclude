//
//  FYDateConfig.swift
//  FYSwift
//
//  Created by wang on 2020/9/15.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

enum SSDateSubMode {
    /**
     减法计算相对精确：只要不是同一年(一个月、一天、一小时、一分、一秒)就会返回差值，并不在乎两个日期是不是只相差一秒
     例如：2020-01-01 和 2019-12-31 的年份差值为1或-1
     例如：2020-01-30 和 2020-02-02 的月份差值为1或-1
     */
    case  SSDateSubModeRelative
    /**
    减法计算精确到日：在计算天、时、分、秒的差值时与 SSDateSubModeRelative 效果相同
    例如：2020-01-02 和 2019-01-03 的月份差值为0
    例如：2020-01-02 和 2019-01-02 的年份差值为1或-1
    */
    case  SSDateSubModeDate
     /** 减法计算精确到秒 */
    case  SSDateSubModeTime
}

enum SSDateWeekMode {
     /** 根据日历显示，认为每周开始第一天为周日 */
    case SSDateWeekModeDefault
     /** 根据我们惯例，认为每周开始第一天为周一 */
    case SSDateWeekModeUsually
}

class SSDateHelper: NSObject {
    static var kHoursOfDay : TimeInterval = 24
    static  var kMinuteOfHour : TimeInterval = 60;
    static  var kSecondsOfMinute : TimeInterval = 60;
    static  var kSecondsOfHour : TimeInterval = kSecondsOfMinute * kMinuteOfHour;
    static  var kSecondsOfDay : TimeInterval = kSecondsOfHour * kHoursOfDay;
    static  var kMinuteOfDay : TimeInterval = kMinuteOfHour * kHoursOfDay
    lazy var dateFormatter : DateFormatter = DateFormatter.init()
    lazy var chineseCalendar : NSCalendar = NSCalendar(calendarIdentifier: .chinese)!
    var kChineseCalendarYears : [String] = ["甲子","乙丑","丙寅","丁卯","戊辰","己巳","庚午","辛未","壬申","癸酉",
                                           "甲戌","乙亥","丙子","丁丑","戊寅","己卯","庚辰","辛己","壬午","癸未",
                                           "甲申","乙酉","丙戌","丁亥","戊子","己丑","庚寅","辛卯","壬辰","癸巳",
                                           "甲午","乙未","丙申","丁酉","戊戌","己亥","庚子","辛丑","壬寅","癸丑",
                                           "甲辰","乙巳","丙午","丁未","戊申","己酉","庚戌","辛亥","壬子","癸丑",
                                           "甲寅","乙卯","丙辰","丁巳","戊午","己未","庚申","辛酉","壬戌","癸亥"]
    var kChineseCalendarMonths:[String] = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
    
    var kChineseCalendarDays : [String] = ["初一","初二","初三","初四","初五","初六","初七","初八","初九","初十",
                                            "十一","十二","十三","十四","十五","十六","十七","十八","十九","二十",
                                            "廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"]
    var kChineseZodiac = ["鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"]
    var kHeavenlyStems = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]
    var kEarthlyBranches = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
    
    
    
    
    static let shared = SSDateHelper()
}

//MARK:NSDate 转为 NSString
extension SSDateHelper {
    
    /*根据指定的formtter返回对应的日期格式
     "y-M-d H:m:s" 年-月-日 时（24h）：分：秒
     "y-M-d h:m:s" 年-月-日 时（12h）：分：秒
     y-M-d h:m  年-月-日 时（12h）：分
     y-M-d H:m 年-月-日 时（24h）：分
     EEE 周一 周二 周三。。。
     eee 星期一 星期二，星期三。。。
     */
    func stringFromDate(date:Date?,formmtter:String) -> String {
        guard let date = date else { return "DATE错误"}
        dateFormatter.dateFormat = formmtter
        return dateFormatter.string(from: date)
    }
}

//MARK: NSString 转为 NSDate
extension SSDateHelper {
    /*根据指定的formtter返回对应的日期格式
        "y-M-d H:m:s" 年-月-日 时（24h）：分：秒
        "y-M-d h:m:s" 年-月-日 时（12h）：分：秒
        y-M-d h:m  年-月-日 时（12h）：分
        y-M-d H:m 年-月-日 时（24h）：分
        EEE 周一 周二 周三。。。
        eee 星期一 星期二，星期三。。。
        */
    func dateFromString(str:String,formmtter:String) -> Date {
        dateFormatter.dateFormat = formmtter
        return dateFormatter.date(from: str)!
    }
}

//MARK:中国农历、生肖
extension SSDateHelper {
    /// 返回 农历年月日 (甲子年二月十五)
    func nl_YMD_stringFromDate(date:Date) -> String {
        let dateComponents : DateComponents = chineseCalendar.components([.year,.month,.day], from: date)
        var year_str = ""
        if let year = dateComponents.year {
            year_str = kChineseCalendarYears[year - 1]
        }
        var month_str : String = ""
        if let month = dateComponents.month {
            month_str = kChineseCalendarMonths[month - 1]
        }
        var day_str = ""
        if let day = dateComponents.day {
            day_str = kChineseCalendarDays[day - 1]
        }
        
        return "\(year_str)\(month_str)\(day_str)"
        
    }
    /// 返回 农历月日 (二月十五)
    func nl_MD_stringFromDate(date:Date) -> String {
        let dateComponents : DateComponents = chineseCalendar.components([.month,.day], from: date)
        var month_str : String = ""
        if let month = dateComponents.month {
            month_str = kChineseCalendarMonths[month - 1]
        }
        var day_str = ""
        if let day = dateComponents.day {
            day_str = kChineseCalendarDays[day - 1]
        }
        
        return "\(month_str)\(day_str)"
    }
    /// 返回 农历年 (甲子年)
    func nl_yearsStringFromDate(date:Date) -> String {
        let dateComponents : DateComponents = chineseCalendar.components(.year, from: date)
        var year_str = ""
        if let year = dateComponents.year {
            year_str = kChineseCalendarYears[year - 1]
        }
        return "\(year_str)"
    }
    /// 返回 农历月 (二月)
    func nl_monthStringFromDate(date:Date) -> String {
        let dateComponents : DateComponents = chineseCalendar.components(.month, from: date)
        var month_str : String = ""
        if let month = dateComponents.month {
            month_str = kChineseCalendarMonths[month - 1]
        }
        return "\(month_str)"
    }
    /// 返回 农历日 (廿五)
    func nl_dayStringFromDate(date:Date) -> String {
        let dateComponents : DateComponents = chineseCalendar.components(.day, from: date)
        var month_str : String = ""
        if let month = dateComponents.day {
            month_str = kChineseCalendarDays[month - 1]
        }
        return "\(month_str)"
    }
    /// 返回 年份所属生肖 (鼠)
    func nl_zodiacStringFromDate(date:Date) -> String {
        let dateComponents : DateComponents = chineseCalendar.components(.day, from: date)
        let zodiacIndex = (dateComponents.year! - 1) % 12
        return kChineseZodiac[zodiacIndex]
    }
    /// 返回 年份所属地支生肖 (子鼠)
    func nl_earthlyBranchesZodiacStringFromDate(date:Date) -> String {
        let dateComponents : DateComponents = chineseCalendar.components(.day, from: date)
        let zodiacIndex = (dateComponents.year! - 1) % 12
        let earthlyBranches = kEarthlyBranches[zodiacIndex]
        let zodiac = kChineseZodiac[zodiacIndex]
        return "\(earthlyBranches)\(zodiac)"
    }
}
//MARK:判断、比较
extension SSDateHelper {
    /**
    判断指定日期是否是今天，只比较年月日
    @param date 指定日期
    @return 当指定日期是今天时 yes，否则 no
    */
    func isTodayForDate(date:Date) -> Bool {
        let dateComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: date)
        let todayComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: Date())
        let comp : DateComponents = NSCalendar.current.dateComponents([.day], from: dateComponents, to: todayComponents)
        return comp.day == 0
    }
    
    /**
    判断指定日期是否是闰年

    @param date 指定日期
    @return 当指定日期在闰年中时 yes，否则 no
    */
    func isLeapYearForDate(date:Date) -> Bool {
        let yearInteger = NSCalendar.current.component(.year, from: date)
         //能被4整除但不能被100整除为普通闰年，能被400整除为世纪闰年
        if ((yearInteger % 4 == 0 && yearInteger % 100 != 0) ||
            yearInteger % 400 == 0) {
            return true
        }
        return false
    }
    /**
    判断两个日期是否是同一天，只比较年月日

    @param fromDate 指定日期
    @param toDate 指定日期
    @return 当两个日期为同一天时 yes，否则 no
    */
    func isSameDayFromDate(fromDate:Date,toDate:Date) -> Bool {
        
        let dateComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: fromDate)
        let todayComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: toDate)
        let comp : DateComponents = NSCalendar.current.dateComponents([.day], from: dateComponents, to: todayComponents)
        return comp.day == 0
    }
    /**
    判断两个日期是否是同时间，只比较年月日时分

    @param fromDate 指定日期
    @param toDate 指定日期
    @return 当两个日期为同时间时 yes，否则 no
    */
    func isSameTimeFromDate(fromDate:Date,toDate:Date) -> Bool {
        let dateComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.minute], from: fromDate)
        let todayComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.minute], from: toDate)
        let comp : DateComponents = NSCalendar.current.dateComponents([.day], from: dateComponents, to: todayComponents)
        return comp.day == 0
    }
    
    /**
    判断指定日期是否比今天早，只比较年月日

    @param date 指定日期
    @return 只有指定日期早于今天时 yes，否则等于晚于都是 no
    */
    func isEarlierThanTodayForDate(date:Date) -> Bool {
        let dateComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: date)
        let todayComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: Date())
        let comp : DateComponents = NSCalendar.current.dateComponents([.day], from: dateComponents, to: todayComponents)
        return comp.day! > 0
    }
    
    /**
    判断指定日期是否比今天晚，只比较年月日

    @param date 指定日期
    @return 只有指定日期晚于今天时 yes，否则等于早于都是 no
    */
    func isLaterThanTodayForDate(date:Date) -> Bool {
        let dateComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: date)
        let todayComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: Date())
        let comp : DateComponents = NSCalendar.current.dateComponents([.day], from: dateComponents, to: todayComponents)
        return comp.day! < 0
    }
}
//MARK:计算：增加、差值
extension SSDateHelper {
    /**
    给指定日期增加指定年数

    @param years 指定年数
    @param toDate 指定日期
    @return 增加指定年数后的新日期
    */
    func dateByAddingYears(years:NSInteger,toDate:Date) -> Date {
        var dateComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: toDate)
        dateComponents.year! += years
        let date = NSCalendar.current.date(from: dateComponents)
        return date ?? Date()
        
    }
    //加月数
    func dateByAddingMonths(months:NSInteger,toDate:Date) -> Date {
        var dateComponents : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: toDate)
        let moveYears = months/12
        let moveMonths = months%12
        dateComponents.year! += moveYears
        dateComponents.month! += moveMonths
        let date = NSCalendar.current.date(from: dateComponents)
        return date ?? Date()
        
    }
    //加天数
    func dateByAddingDays(days:TimeInterval,toDtae:Date) -> Date {
        let date = toDtae.addingTimeInterval(days * SSDateHelper.kSecondsOfDay)
        return date
    }
    //加小时
    func dateByAddingHours(hours:TimeInterval,toDtae:Date) -> Date {
        let date = toDtae.addingTimeInterval(hours * SSDateHelper.kSecondsOfHour)
        return date
    }
    //加分钟
    func dateByAddingMinutes(minutes:TimeInterval,toDtae:Date) -> Date {
        let date = toDtae.addingTimeInterval(minutes * SSDateHelper.kSecondsOfMinute)
        return date
    }
    //加秒
    func dateByAddingSeconds(seconds:TimeInterval,toDtae:Date) -> Date {
        let date = toDtae.addingTimeInterval(seconds)
        return date
    }
    
    /**
    计算 date 减去 subDate 的年份差

    @param date 减数日期
    @param subDate 被减数日期
    @param mode 指定精确方式
    @return 返回 date 减去 subDate 的年份差值
    */
    func yearsDifferenceForDate(date:Date,subDate:Date,subMode:SSDateSubMode) -> NSInteger {
        
        if subMode == .SSDateSubModeRelative {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year], from: dateComp, to: subDateComp)
            return comp.year ?? 0
            
        } else if subMode == .SSDateSubModeDate {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day], from: dateComp, to: subDateComp)
            return comp.year ?? 0
        } else {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateComp, to: subDateComp)
            return comp.year ?? 0
           
        }
       
    }
    //减去月份差
    func monthsDifferenceForDate(date:Date,subDate:Date,subMode:SSDateSubMode) -> NSInteger {
        if subMode == .SSDateSubModeRelative {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year], from: dateComp, to: subDateComp)
            return comp.month ?? 0
            
        } else if subMode == .SSDateSubModeDate {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day], from: dateComp, to: subDateComp)
            return comp.month ?? 0
        } else {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateComp, to: subDateComp)
            return comp.month ?? 0
            
        }
    }
    //天数差
    func daysDifferenceForDate(date:Date,subDate:Date,subMode:SSDateSubMode) -> NSInteger {
        if subMode == .SSDateSubModeRelative {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year], from: dateComp, to: subDateComp)
            return comp.day ?? 0
            
        } else if subMode == .SSDateSubModeDate {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day], from: dateComp, to: subDateComp)
            return comp.day ?? 0
        } else {
            let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: subDate)
            let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateComp, to: subDateComp)
            return comp.day ?? 0
            
        }
    }
    //小时差
    func hoursDifferenceForDate(date:Date,subDate:Date) -> NSInteger {
        
        let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: subDate)
        let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateComp, to: subDateComp)
        return comp.hour ?? 0
        
        
    }
    //分差
    func minutesDifferenceForDate(date:Date,subDate:Date) -> NSInteger {
        let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: subDate)
        let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateComp, to: subDateComp)
        return comp.minute ?? 0
    }
    //秒差
    func secondsDifferenceForDate(date:Date,subDate:Date) -> NSInteger {
        let dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: subDate)
        let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateComp, to: subDateComp)
        return comp.second ?? 0
    }
    
    /**
    计算 date 减去 subDate 的星期差

    @param date 减数日期
    @param subDate 被减数日期
    @param mode 指定星期开始方式
    @return 计算 date 减去 subDate 的星期差值
    */
    func weeksDifferenceForDate(date:Date,subDate:Date,subMode:SSDateWeekMode) -> NSInteger {
        var dateComp :DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.weekday], from: date)
        var subDateComp : DateComponents = NSCalendar.current.dateComponents([.year,.month,.day,.weekday], from: subDate)
        let comp : DateComponents =  NSCalendar.current.dateComponents([.year,.month,.day,.weekday], from: dateComp, to: subDateComp)
        if subMode == .SSDateWeekModeUsually {
            //如果以我们平时习惯的周天为周末，就要重新架构weekday的排序。
            //需要先把默认weekday往前移一位，在把代表周天的0移到7。
            dateComp.weekday! -= 1
            subDateComp.weekday! -= 1
            dateComp.weekday! = (dateComp.weekday! == 0) ? 7 : dateComp.weekday!
            subDateComp.weekday! = (subDateComp.weekday! == 0) ? 7 : subDateComp.weekday!
        }
        let weekdayDifference : NSInteger = dateComp.weekday! - subDateComp.weekday!
        let dayDifference = comp.day!
        let weekDifference = (dayDifference - weekdayDifference) / 7
        return weekDifference
    }
    
}

class FYDateConfig: NSObject {

}
