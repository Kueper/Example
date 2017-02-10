//
//  CoreGraphics+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-07.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    static func square(_ side: CGFloat) -> CGSize {
        return CGSize(width: side, height: side)
    }
}

extension UIBezierPath {
    
    func advance(x: CGFloat) {
        
        self.addLine(to: CGPoint(x: currentPoint.x + x, y: currentPoint.y))
    }
    
    func advance(y: CGFloat) {
        self.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y + y))
    }
    
    func advance(x: CGFloat, y: CGFloat) {
        self.addLine(to: CGPoint(x: currentPoint.x + x, y: currentPoint.y + y))
    }
    
    func move(x: CGFloat, y: CGFloat) {
        self.move(to: CGPoint(x: x, y: y))
    }
}
