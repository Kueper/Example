//
//  PlaceholderInteractiveView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-13.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A subclass that turns any UIView object into an interactive touch-recognizing view
 
 InteractiveView has an extension to it that provides a default implementation for the
 animation methods. Any subclass could override that implementation there. Could also remove the protocol
 method if desired and make the animation implementation here instead
 */
class PlaceholderInteractiveView: UIView, InteractiveView {

    var action: (() -> Void)? { didSet { setupGesture() }}
    
    internal var _views = [String : UIView]()
    internal var _constraints = [NSLayoutConstraint]()
    
    private var tapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    internal func setupViews() {
        
    }
    
    internal func setupConstraints() {
        
    }
    
    private func setupGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(executeAction))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc internal func executeAction() {
        action?()
    }
    
    override internal func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.animateViewForTouchesBegan()
    }
    
    override internal func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        self.animateViewForTouchesEnded()
    }
    
    override internal func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        self.animateViewForTouchesEnded()
    }
    
}
