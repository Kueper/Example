//
//  CornersView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-28.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit
import Foundation

class CornersView: UIView {

    // settable properties
    var colour: UIColor = Colour.white { didSet { setNeedsDisplay() }}
    var characteristicLength: CGFloat = 0.2 { didSet { setNeedsDisplay() }}
    
    // internal properties
    fileprivate let path = UIBezierPath()
    
    override func draw(_ rect: CGRect) {
        
        // initialize
        let length = rect.width * characteristicLength
        path.removeAllPoints()
        
        // top left corner
        // start top left, bottom of angle
        path.move(x: rect.origin.x, y: rect.origin.y + length)
        path.addLine(to: rect.origin)
        path.advance(x: length)
        path.move(x: rect.width - length, y: rect.origin.y)
        
        // top right
        path.advance(x: length)
        path.advance(y: length)
        path.move(x: rect.width, y: rect.height - length)
        
        // bottom right
        path.advance(y: length)
        path.advance(x: -length)
        path.move(x: rect.origin.x + length, y: rect.height)
        
        // bottom left
        path.advance(x: -length)
        path.advance(y: -length)
        
        // draw line
        colour.setStroke()
        path.lineCapStyle = .square
        path.lineWidth = CGFloat(4)
        path.stroke()
    }
}
