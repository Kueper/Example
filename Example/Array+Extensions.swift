//
//  Array+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-06.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: Object {
    
    subscript (id id: Int?) -> Element? {
        
        get {
            for element in self {
                if element.id == id && id != nil {
                    // we don't have exact type safety here
                    // because we could technically compare a reminder to an event
                    // but we're going to use this anyway for now
                    // prudently however, this should be implemented for each final class
                    return element
                }
            }
            
            return nil
        }
    }
}

extension Sequence where Iterator.Element == Int {
    
    func sum() -> Int {

        // replace with reduce later
        var sum = 0
        for element in self {
            sum = sum + element
        }
        
        return sum
    }
}

extension Collection where Iterator.Element == String {
    
    func constraints(on views: [String : UIView]) -> [NSLayoutConstraint] {
        return self.map( { Constraint.VFLS($0, views: views) }).flatMap({ $0 })
    }
    
    func expressCasually() -> String {
        guard self.count > 0 else { return "" }
        
        if self.count == 1 {
            // single item
            return self.first!
        } else {
            // more than one item
            var string = ""
            for (index, item) in self.enumerated() {
                if index == (self.underestimatedCount - 1) {
                    // last item, add "and
                    string += NSLocalizedString("and ", comment: "As in 'x, y and z' ") + item
                } else if index == self.underestimatedCount - 2 {
                    // say no to the oxford comma!
                    string += item + " "
                } else {
                    string += item + ", "
                }
            }
            
            return string
        }
    }
}

extension Array where Element: NSLayoutConstraint {
    
    func activate() {
        NSLayoutConstraint.activate(self)
    }
    
    func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
}

extension Array where Element: Hashable {
    
    func unique() -> Array {
        var seen: [Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
    
    mutating func removeObject(_ element: Element) {
        
        for (i, _element) in self.enumerated() {
            if element == _element {
                self.remove(at: i)
                break
            }
        }
    }
}

