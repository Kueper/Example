//
//  PlaceholderPicker.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderPicker: PlaceholderView {
    
    // date selector
    let barButton = UIButton()
    let checkMarkView = CheckMarkView()
    
    internal let container = UIView()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["checkmark"] = checkMarkView
        _views["button"] = barButton
        _views["container"] = container
        
        barButton.addSubview(checkMarkView)
        
        self.addSubviews([barButton, container])
        
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Colour.white
        
        barButton.translatesAutoresizingMaskIntoConstraints = false
        barButton.backgroundColor = Colour.white
        barButton.setTitleColor(Colour.charcoal, for: .normal)
        
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        checkMarkView.startDrawn = true
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:[self(\(UIScreen.main.bounds.width))]", views: ["self" : self])
        
        _constraints += Constraint.VFLS("H:|-0-[container]-0-|", views: _views)
        
        _constraints += Constraint.VFLS("V:|-0-[button(44)]-0-[container(240@500)]-0-|", views: _views)
        _constraints += Constraint.VFLS("H:|-0-[button]-0-|", views: _views)
        
        _constraints += Constraint.VFLS("H:[checkmark(30)]-20-|", views: _views)
        _constraints += Constraint.VFLS("V:|-8-[checkmark]-8-|", views: _views)
        _constraints.activate()
    }
    
    func setTitleText(_ title: String) {
        self.barButton.setTitle(title, for: .normal) 
    }
}
