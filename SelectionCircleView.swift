//
//  SelectionCircleView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 
 A generic UIView that draws a circle at radius == width/2.
 
 and an internal circle if it is selected.
 
 Could be made an implementation of UIButton to take advantage of state handling,
 but that could introduce annoying layout issues with label / image setting. Could also be
 made an implementation of PlaceholderInteractiveView to animate the touches.
 
 */

class SelectionCircleView: CircleView {
    
    // redraw on change
    var selected: Bool = false { didSet { setNeedsDisplay() }}
    
    override var tintColor: UIColor! { didSet { setNeedsDisplay() }}
    
    override internal func setupViews() {
        super.setupViews()
        
        self.tintColor = Colour.hizentraBlue
    }
    
    override func draw(_ rect: CGRect) {
        
        // do the outer border first, it is always showing
        
        // calculate maximum sizes so circle's stroke just touches smallest dimension's edges
        let center = CGPoint(x: rect.width/2, y: rect.height/2)

        let outerDiameter = min(rect.width, rect.height)
        let outerRadius = outerDiameter/2 - borderWidth/2
        
        let innerRadius = 0.7*outerRadius
        
        // set up bezier path for the outer path
        bezierPath = UIBezierPath(
            arcCenter: center,
            radius: outerRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true)
        
        bezierPath.close()
        bezierPath.lineWidth = borderWidth
        
        // stroke
        (borderColour ?? tintColor)?.setStroke()
        bezierPath.stroke()
        
        if selected == true {
            // add the circle
            bezierPath = UIBezierPath(
                arcCenter: center,
                radius: innerRadius,
                startAngle: 0,
                endAngle: CGFloat(2*M_PI),
                clockwise: true)
            
            bezierPath.close()
            
            (fillColour ?? tintColor)?.setFill()
            bezierPath.fill()
        }
    }
}
