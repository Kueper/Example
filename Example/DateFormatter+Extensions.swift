//
//  DateFormatter+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-21.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    class func estDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        return dateFormatter
    }
    
    class func localDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
    
    class func utcDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }
}
