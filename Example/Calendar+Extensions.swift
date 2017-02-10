//
//  Calendar+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-03.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation

extension Calendar {
    
    static public func weekday(_ number: Int) -> String {
        switch number {
        case 0:
            return NSLocalizedString("Sunday", comment: "No comment")
        case 1:
            return NSLocalizedString("Monday", comment: "No comment")
        case 2:
            return NSLocalizedString("Tuesday", comment: "No comment")
        case 3:
            return NSLocalizedString("Wednesday", comment: "No comment")
        case 4:
            return NSLocalizedString("Thursday", comment: "No comment")
        case 5:
            return NSLocalizedString("Friday", comment: "No comment")
        case 6:
            return NSLocalizedString("Saturday", comment: "No comment")
        default:
            return ""
        }
    }
    
    static public func weekdays(_ dates: [Int]) -> [String] {
        return dates.map({ Calendar.weekday($0) })
    }
    
}
