//
//  UIFont+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-13.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func Avenir(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir", size: size)!
    }
    
    class func AvenirBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Bold", size: size)!
    }
    
    class func AvenirMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: size)!
    }
    
    class func AvenirMediumItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-MediumOblique", size: size)!
    
    }
    
    class func AvenirHeavyItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-MediumOblique", size: size)!
        
    }
}
