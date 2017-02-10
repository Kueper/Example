//
//  SegmentedControlTableViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-09.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A table view cell with a label to the left and a segmented control on the right
 */
class SegmentedControlTableViewCell: TableViewCell {
    
    var label = UILabel()
    var segmentedControl = UISegmentedControl()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["control"] = segmentedControl
        _views["label"] = label
        
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.safelyAddSubview(view)
        }
        
        label.font = UIFont.Avenir(size: 16)
        label.textColor = Colour.charcoal
        
        segmentedControl.tintColor = Colour.hizentraBlue
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-20-[label(100)]-20-[control]-20-|", views: _views)
        _constraints += Constraint.VFLS("V:|-8-[label]-8-|", views: _views)
        _constraints += Constraint.VFLS("V:[control(40)]", views: _views)
        _constraints.append(Constraint(item: segmentedControl, attribute: .centerY, relatedBy: .equal, toItem: label, attribute: .centerY, multiplier: 1, constant: 0))
        _constraints.activate()
    }
}
