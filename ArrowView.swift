//
//  ArrowView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-21.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class ArrowView: PlaceholderInteractiveView {
    
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() }}
    var strokeColor = UIColor.lightGray { didSet { setNeedsDisplay() }}
    var lineCapStyle: CGLineCap = .round { didSet { setNeedsDisplay() }}
    var lineJoinStyle: CGLineJoin = .round
    var fill = false { didSet { setNeedsDisplay() }}
    
    override var tintColor: UIColor! {
        willSet {
            // make sure value is not nil
            if let value = newValue {
                self.strokeColor = value
            }
        }
    }
    
    private var path = UIBezierPath()
    
    enum Direction {
        case left
        case right
        case up
        case down
    }
    
    var direction: Direction = .left { didSet { setNeedsDisplay() }}
    
    required convenience init(direction: Direction) {
        self.init()
        self.direction = direction
        
        setupViews()
        setupConstraints()
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        path.lineJoinStyle = lineJoinStyle
        path.lineCapStyle = lineCapStyle
        let buffer = lineWidth/2 + 1
        
        switch direction {
        case .left, .up:
            path.move(to: CGPoint(x: rect.width-buffer, y: rect.origin.y+buffer))
            path.addLine(to: CGPoint(x: buffer, y: rect.height / 2))
            path.addLine(to: CGPoint(x: rect.width-buffer, y: rect.height-buffer))
        case .down:
            path.move(to: CGPoint(x: rect.origin.x+buffer, y: rect.origin.y+buffer))
            path.addLine(to: CGPoint(x: rect.width/2, y: rect.height - buffer))
            path.addLine(to: CGPoint(x: rect.width-buffer, y: rect.origin.y+buffer))
        case .right:
            path.move(to: CGPoint(x: rect.origin.x+buffer, y: rect.origin.y+buffer))
            path.addLine(to: CGPoint(x: rect.width-buffer, y: rect.height / 2))
            path.addLine(to: CGPoint(x: rect.origin.x+buffer, y: rect.height-buffer))
        }
        
        path.lineWidth = lineWidth
        
        if fill == true { path.close() }
        
        strokeColor.set()
        path.stroke()
        
        if fill == true { path.fill() }
    }
}
