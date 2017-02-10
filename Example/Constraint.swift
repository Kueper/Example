//
//  Constraint.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-04.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

class Constraint: NSLayoutConstraint {
    
    /**
     Visual formatted language short form
     */
    class func VFL(_ format: String, options: NSLayoutFormatOptions, metrics: [String : Any]?, views: [String : Any]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: views)
    }
    
    /**
     Visual formatted language short form + metrics set to nil and options empty
     */
    class func VFLS(_ format: String, views: [String : UIView]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: views)
    }
    
    class func matchSuperview(_ view: UIView) {
        var _constraints = Constraint.VFLS("H:|[view]|", views: ["view" : view])
        _constraints += Constraint.VFLS("V:|[view]|", views: ["view" : view])
        _constraints.activate()
    }
    
    class func matchSuper(_ view: UIView) -> [NSLayoutConstraint] {
        var _constraints = Constraint.VFLS("H:|[view]|", views: ["view" : view])
        _constraints += Constraint.VFLS("V:|[view]|", views: ["view" : view])
        return _constraints
    }
}

