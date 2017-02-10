//
//  NumberPickerViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class NumberPickerViewController: BasePromptViewController {
    
    let numberPicker = NumberPicker()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["numberPicker"] = numberPicker
        
        _views.falsifyAutoResizingMaskForViews()
        
        self.promptView.addSubview(numberPicker)
        
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // match action sheet to the prompt view
        // let action sheet determine it's own height
        _constraints += Constraint.matchSuper(numberPicker)
        _constraints.activate()
    }
}
