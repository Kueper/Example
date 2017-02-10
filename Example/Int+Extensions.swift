//
//  Int+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-03.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    public var ordinalAbbreviation: String {
        var suffix: String = ""
        let ones: Int = self % 10
        let tens: Int = (self / 10) % 10
        
        if (tens == 1) {
            suffix = "th"
        } else if (ones == 1) {
            suffix = "st"
        } else if (ones == 2) {
            suffix = "nd"
        } else if (ones == 3) {
            suffix = "rd"
        } else {
            suffix = "th"
        }
        
        return "\(self)\(suffix)"
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var float: Float {
        return Float(self)
    }
    
    var string: String {
        return String(self)
    }
}

extension Bool {
    
    var int: Int {
        return self ? 1 : 0
    }
}
