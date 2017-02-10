//
//  TitleTextFieldTableViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-15.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A cell with a title label - textfield combination. No preference set to width, they share the
 horizontal space evenly
 */
class TitleTextFieldTableViewCell: TextFieldTableViewCell {
    
    var titleLabel = UILabel()

    override internal func setupViews() {
        super.setupViews()
        
        _views["title"] = titleLabel
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        textField.textAlignment = .right
        textField.font = UIFont.Avenir(size: 18)
        
        titleLabel.textColor = Colour.hizentraBlue
        titleLabel.font = UIFont.Avenir(size: 18)
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints.deactivate()
        
        // implicit height of 52 here
        _constraints = ["V:|-12-[title(>=30)]-12-|",
                        "V:|-12-[textField(>=30)]-12-|",
                        "H:|-24-[title]-6-[textField]-24-|"].constraints(on: _views)
        _constraints.activate()
    }
}
