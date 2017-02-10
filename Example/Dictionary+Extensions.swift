//
//  Dictionary+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-04.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

extension Sequence where Iterator.Element == (key: String, value: UIView) {
    
    func falsifyAutoResizingMaskForViews() {
        self.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func safelyAddViews(to view: UIView) {
        self.forEach { (_, value) in
            view.safelyAddSubview(value)
        }
    }
}
