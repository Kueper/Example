//
//  Date+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-14.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation

extension Date {
    
    /**
     > Local TZ
     
     (lldb) po NSDate().time()
     "11:39 AM"
     */
    func time() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }
    
    /**
     > UTC
     > yyyy-MM-dd HH:mm:ss
     
     (lldb) po NSDate().stringUTC()
     "2016-06-07 15:43:25"
     */
    func stringUTC() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
    }
    
    /**
     > Local TZ
     
     (lldb) po NSDate().dateOnly()
     > need to fill out with example
     */
    func dateOnly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }
    
    func yyyyMMdd() -> String {
        let dateFormatter = DateFormatter.utcDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    /**
     Returns the day of the week, and Today / Yesterday for dates within 48 hours
     */
    func weekDay() -> String {

        var string = ""
        
        let today = Date().day
        let day = self.day
        
        if day == today {
            // today
            string =  NSLocalizedString("Today", comment: "No comment")
        } else if day == today - 1 {
            // yesterday
            string =  NSLocalizedString("Yesterday", comment: "No comment")
        } else { //if interval < (today + 60*60*24*6) {
            // within last week

            let weekday = Calendar.current.component(.weekday, from: self)
            
            switch weekday {
            case 1: string =  NSLocalizedString("Sunday", comment: "No comment")
            case 2: string =  NSLocalizedString("Monday", comment: "No comment")
            case 3: string =  NSLocalizedString("Tuesday", comment: "No comment")
            case 4: string =  NSLocalizedString("Wednesday", comment: "No comment")
            case 5: string =  NSLocalizedString("Thursday", comment: "No comment")
            case 6: string =  NSLocalizedString("Friday", comment: "No comment")
            case 7: string =  NSLocalizedString("Saturday", comment: "No comment")
            default: string =  ""
            }
        }
        
        return string + " - " + self.dateOnly()
    }
    
    /**
     > UTC
     > yyyy-MM-dd 00:00:00 (aka 12AM in UTC)
     
     (lldb) po NSDate().removeHHmmssUTC()
     ▿ Optional<NSDate>
     - Some : 2016-06-07 00:00:00 +0000
     */
    func removeHHmmssUTC() -> Date? {
        let dateFormatter = DateFormatter.utcDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: self)
        return dateFormatter.date(from: dateString)
    }
    
    func removeHHmmssLocal() -> Date? {
        let dateFormatter = DateFormatter.localDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: self)
        return dateFormatter.date(from: dateString)
    }
    
    var month: String {
        let month = Calendar.current.component(.month, from: self)
        
        switch month {
        case 1: return NSLocalizedString("January", comment: "No comment")
        case 2: return NSLocalizedString("February", comment: "No comment")
        case 3: return NSLocalizedString("March", comment: "No comment")
        case 4: return NSLocalizedString("April", comment: "No comment")
        case 5: return NSLocalizedString("May", comment: "No comment")
        case 6: return NSLocalizedString("June", comment: "No comment")
        case 7: return NSLocalizedString("July", comment: "No comment")
        case 8: return NSLocalizedString("August", comment: "No comment")
        case 9: return NSLocalizedString("September", comment: "No comment")
        case 10: return NSLocalizedString("October", comment: "No comment")
        case 11: return NSLocalizedString("November", comment: "No comment")
        case 12: return NSLocalizedString("December", comment: "No comment")
        default: return ""
        }
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
}
