//
//  PlaceholderAnimatableView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-18.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A subclass of PlaceholderInteractiveView that provides the handling for animating a shape layer. Define the shape layer
 by overriding `drawRect(rect: CGRect)`
 */
class PlaceholderAnimatableView: PlaceholderInteractiveView {
    
    var lineWidth: CGFloat = 3
    var strokeColour = Colour.green
    var completion: (()-> Void)?
    
    override var tintColor: UIColor! {
        willSet {
            // make sure value is not nil
            if let value = newValue {
                self.strokeColour = value
            }
        }
    }
    
    internal var path = UIBezierPath()
    internal var shapeLayer = CAShapeLayer()
    
    override func setupViews() {
        super.setupViews()
        
        self.backgroundColor = UIColor.clear
        self.layer.addSublayer(shapeLayer)
    }
    
    func animate() {
        
        // Configure the animation
        // Animate from the full stroke being drawn to none of the stroke being drawn
//        shapeLayer.strokeEnd = 0.0
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.fromValue = 0.0
        drawAnimation.toValue = 1.0
        drawAnimation.beginTime = CACurrentMediaTime().advanced(by: 0.1)
        drawAnimation.duration = 1
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.fillMode = kCAFillModeForwards
        drawAnimation.delegate = self
    }
}

extension PlaceholderAnimatableView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag == true {
            self.completion?()
        }
    }
}
