//
//  CheckMarkView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-18.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 An interactive view that animates a greed checkmark within its bounds
 */
class CheckMarkView: PlaceholderAnimatableView {
    
    var startDrawn: Bool = false
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let buffer = lineWidth/2 + 1
        let inset = min(rect.width, rect.height)*0.2
        
        // left, mid height
        path.move(to: CGPoint(x: rect.origin.x+buffer+inset, y: rect.origin.y + rect.height*0.5))
        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height-buffer-inset))
        path.addLine(to: CGPoint(x: rect.width-buffer-inset*0.5, y: rect.origin.y+buffer+inset))
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColour.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.lineCap = "round"
        shapeLayer.lineWidth = lineWidth
        
        // When it gets to the end of its animation, leave it at 0% stroke filled
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = startDrawn ? 1.0 : 0.0
    }
    
}
