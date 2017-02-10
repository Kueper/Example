//
//  DatePickerViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-16.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class DatePickerViewController: BasePromptViewController  {

    let datePicker = DatePicker()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["datePicker"] = datePicker
        
        _views.falsifyAutoResizingMaskForViews()
        
        self.promptView.addSubview(datePicker)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // match action sheet to the prompt view
        // let action sheet determine it's own height
        _constraints += Constraint.matchSuper(datePicker)
        _constraints.activate()
    }
}
