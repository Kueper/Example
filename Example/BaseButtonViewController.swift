//
//  BaseButtonViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-19.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit
/**
 A subclass of Placeholder that provides a PlaceholderWidthButton at the bottom.
 
 Override `baseButtonAction(_:)` in subclasses to provide base button handling in your implementation
*/
class BaseButtonViewController: PlaceholderViewController {

    internal var button = PlaceholderWidthButton()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["button"] = button
        
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.safelyAddSubview(view)
        }
        
        button.style = .standard
        button.addTarget(self, action: #selector(baseButtonAction(_:)), for: .touchUpInside)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-0-[button]-0-|", views: _views)
        _constraints += Constraint.VFLS("V:[button(60)]-0-|", views: _views)
        _constraints.activate()
    }
    
    @objc internal func baseButtonAction(_ sender: Any?) {
        
    }
}

