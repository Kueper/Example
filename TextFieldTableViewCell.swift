//
//  TextFieldTableViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-09.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A table view cell with a text field that occupies the view
 */
class TextFieldTableViewCell: TableViewCell {
    
    var textField = UITextField()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["textField"] = textField
        contentView.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Colour.charcoal
        textField.font = UIFont.Avenir(size: 14)
        textField.adjustsFontSizeToFitWidth = true
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-20-[textField]-20-|", views: _views)
        _constraints += Constraint.VFLS("V:|-6-[textField]-6-|", views: _views)
        _constraints.activate()
    }
}
