//
//  PlaceholderWidthButton.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-12.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

/**
 A view with a rounded button in Placeholder's colours, indended to be laid out as a full width view at the bottom of a page
*/
class PlaceholderWidthButton: PlaceholderView {
    
    private let button = PlaceholderButton()
    
    var state: UIControlState = .normal { didSet { updateSelf() }}
    
    /**
     Two standardized view states
     Standard has a blue button background
     
     Inverted has a light grey button background
     */
    var style: Style = .standard { didSet { updateSelf() }}

    enum Style {
        case inverted
        case standard
        case hoth
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["button"] = button
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        button.borderStyle = .round
        
        updateSelf()
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-20-[button]-20-|", views: _views)
        _constraints += Constraint.VFLS("V:|-8-[button]-8-|", views: _views)
        _constraints.activate()
    }
    
    func addTarget(_ target: Any?, action: Selector, for events: UIControlEvents) {
        self.button.addTarget(target, action: action, for: events)
    }
    
    func setTitle(_ title: String?, for controlState: UIControlState) {
        self.button.setTitle(title, for: controlState)
    }
    
    private func updateSelf() {
        
        switch self.style {
        case .standard:
            // grey background, blue button background, grey text
            self.backgroundColor = self.state == .disabled ? Colour.shadowGrey : Colour.lightGrey
            self.button.style = .blue
        case .inverted:
            // blue background, grey button background, blue text
            self.backgroundColor = Colour.hizentraBlue
            self.button.style = .white
        case .hoth:
            // grey background, white button background, blue border, blue text, disabled = button text colour = grey
            self.backgroundColor = Colour.lightGrey
            self.button.style = .white
            self.button.borderStyle = .roundBlue
        }
        
        self.button.isEnabled = self.state != .disabled
    }
}
