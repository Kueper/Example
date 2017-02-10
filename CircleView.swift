//
//  CircleView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-12-01.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 
 A generic UIView that draws a circle at radius == width/2.
 
 */
class CircleView: PlaceholderView {
    
    // circle attributes
    var fill = false { didSet { setNeedsDisplay() }}
    var fillColour: UIColor? { didSet { setNeedsDisplay() }}
    
    // path attributes
    var borderWidth = CGFloat(2)
    var borderColour: UIColor? { didSet { setNeedsDisplay() }}
    
    // path
    internal(set) var bezierPath = UIBezierPath()
    
    override internal func setupViews() {
        super.setupViews()
        self.backgroundColor = Colour.clear
    }
    
    override func draw(_ rect: CGRect) {
        
        // calculate maximum sizes so circle's stroke just touches smallest dimension's edges
        let diameter = min(rect.width, rect.height)
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        let radius = diameter/2 - borderWidth/2
        
        // set up bezier path
        bezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        bezierPath.close()
        bezierPath.lineWidth = borderWidth
        
        // fill first, stroke will be partially covered otherwise
        if fill == true {
            (fillColour ?? tintColor)?.set()
            bezierPath.fill()
        }
        
        // stroke
        (borderColour ?? tintColor)?.set()
        bezierPath.stroke()
    }
}
