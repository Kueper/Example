//
//  DoubleDatePicker.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-10.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class DoubleDatePicker: DatePicker {
    
    // date selector
    let arrowView = ArrowView(direction: .right)
    
    var state: State = .doubleDate
    
    enum State {
        case doubleDate
        case dateTime
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["arrow"] = arrowView
        
        barButton.addSubview(arrowView)
        
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        checkMarkView.isHidden = true
        checkMarkView.action = {
            self.delegate?.didSelect(date: self.datePicker.date)
            self.datePicker.datePickerMode = .date // reset the mdoe here for re-use
        }
        
        arrowView.action = {
            self.delegate?.didSelect(date: self.datePicker.date)
            self.arrowView.isHidden = true
            self.checkMarkView.isHidden = false
            self.datePicker.datePickerMode = self.state == .doubleDate ? .date : .time
        }
        
        arrowView.strokeColor = Colour.charcoal
        arrowView.fill = false
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        arrowView.backgroundColor = UIColor.clear
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:[arrow(12)]-20-|", views: _views)
        _constraints += Constraint.VFLS("V:|-12-[arrow]-12-|", views: _views)
        _constraints.activate()
    }
}
