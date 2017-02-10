//
//  Protocols.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-05.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

/**
 Protocol for all objects handled by the server
 
 This will guarantee all have an Id and an initializer by Id
 */
protocol ObjectProtocol {
    var id: Int?     { get set }
}

/**
 Generic protocol enforcing animation scheme for a view that should animate on touch events.
 */
protocol InteractiveView {
    func animateViewForTouchesBegan()
    func animateViewForTouchesEnded()
}

/**
 Generic protocol to toggle types with two values, or cycle progressively if n > 2.
*/
protocol Toggleable: WithCollection {
    mutating func toggle()
}

protocol WithCollection: Hashable {

    static var collection: [Self] { get }
}

extension WithCollection {
    
    static var collection: [Self] {
        
        typealias S = Self
        let x = AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
        
        return x.map({ $0 })
    }
}

extension Toggleable {
    
    mutating func toggle() {
        
        let collection = Self.collection
        
        if collection.count == 2 {
            // alternate
            self = (self == collection[0]) ? collection[1] : collection[0]
        } else {
            // advance through
            for (index, value) in collection.enumerated() {
                if value == self {
                    // found the current value
                    if index < (collection.count - 1) {
                        // can move forward
                        self = collection[index + 1]
                    } else {
                        // restart
                        self = collection[0]
                    }
                    break
                }
            }
        }
    }
}

