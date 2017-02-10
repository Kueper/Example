//
//  DatePicker.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-31.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func didSelect(date: Date)
}

class DatePicker: PlaceholderPicker {
    
    let datePicker = UIDatePicker()
    
    var delegate: DatePickerDelegate?
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["datePicker"] = datePicker
        
        _views.falsifyAutoResizingMaskForViews()
        container.addSubview(datePicker)
        
        self.datePicker.datePickerMode = .date
        self.datePicker.backgroundColor = Colour.white
        
        // default action, likely overridden to dismiss date picker
        checkMarkView.action = {
            self.delegate?.didSelect(date: self.datePicker.date)
        }
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.matchSuper(datePicker)
        _constraints.activate()
    }
}
