//
//  BaseTableViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-24.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class BaseTableViewCell: TableViewCell {

    internal var leftView = UIView()
    internal var majorLabel = UILabel()
    internal var minorLabel = UILabel()
    fileprivate var labelsView = UIView()
    
    internal var leftButton: PlaceholderButton?
    internal var rightButton: PlaceholderButton?
    internal var _buttonConstraints: [NSLayoutConstraint] = []
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["leftView"] = leftView
        _views["major"] = majorLabel
        _views["minor"] = minorLabel
        _views["labelsView"] = labelsView
        
        labelsView.addSubviews([majorLabel, minorLabel])
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self.contentView)
        
        minorLabel.textAlignment = .left
        minorLabel.adjustsFontSizeToFitWidth = true
        minorLabel.textColor = Colour.charcoal
        minorLabel.font = UIFont.Avenir(size: 14)
        
        majorLabel.textAlignment = .left
        majorLabel.adjustsFontSizeToFitWidth = true
        majorLabel.textColor = Colour.charcoal
        majorLabel.font = UIFont.AvenirMedium(size: 16)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += ["H:|-0-[leftView]-0-[labelsView]-16-|",
                         "V:|-0-[leftView]",
                         // ensure labels is 12 pts below the top
                         "V:|-12-[labelsView]",
                         // labels within their view
                         "H:|-0-[major]-0-|",
                         "H:|-0-[minor]-0-|",
                         "V:|-0-[major]-0-[minor]-0-|"].constraints(on: _views)
        
        // constrain bottom of left view to the bottom of the labels view, with the same spacer as on top
        // this ensures left view will always center with labels, but the cell can still grow downwards
        _constraints.append(Constraint(item: leftView, attribute: .bottom, relatedBy: .equal, toItem: labelsView, attribute: .bottom, multiplier: 1, constant: 12))
        
        // low priority center the labels are centered vertically in the cell
        // this also implies a baseline vertical height of the cell with the 12 pts vert offset of labelsView
        let centerCon = Constraint(item: labelsView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0)
        centerCon.priority = 750
        _constraints.append(centerCon)
        _constraints.activate()
    }
    
    internal func removeButtons() {
        // remove from view
        leftButton?.removeFromSuperview()
        _buttonConstraints.deactivate()
    }
    
    internal func addButtons() {
        
        // ensure buttons are created
        leftButton == nil ? leftButton = PlaceholderButton() : ()
        rightButton == nil ? rightButton = PlaceholderButton() : ()
        
        // update views dictionary
        _views["leftButton"] = leftButton
        _views["rightButton"] = rightButton
        
        // setup views for layout
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self.contentView)
        
        // style views
        leftButton?.style = .blue
        leftButton?.borderStyle = .round
        
        rightButton?.style = .white
        rightButton?.borderStyle = .round
        
        // constraint views
        _buttonConstraints.deactivate()
        _buttonConstraints = ["H:|-20-[leftButton]-20-[rightButton(100)]-20-|",
                              "V:[labelsView]-12-[leftButton(30)]-12-|",
                              "V:[labelsView]-12-[rightButton(30)]"].constraints(on: _views)
        _buttonConstraints.activate()
    }
}
