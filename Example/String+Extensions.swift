//
//  String+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-27.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation

extension String {
    
    var isNumerical: Bool {
        // Only allow numbers. Look for anything not a number.
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil && self.characters.count > 0)
    }

    var isEmail: Bool {
        let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
    
    var isPhoneNumber: Bool  {
        
        let regex = try? NSRegularExpression(pattern: "[0-9]{10}", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
    
    /**
     Converts a string to time in UTC
     
     Works with "yyyy-MM-dd HH:mm:ss"
     and "yyyy-MM-dd" formats.
     */
    func dateUTC() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: self)
    }
    
    /**
     Converts a string to a date object in local time
     
     Works with "yyyy-MM-dd HH:mm:ss"
     and "yyyy-MM-dd" formats.
     */
    func dateLocal() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }
}
