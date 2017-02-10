//
//  MasterDetailTableViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-03.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class MasterDetailTableViewCell: TableViewCell {

    var masterLabel = UILabel()
    var detailLabel = UILabel()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["master"] = masterLabel
        _views["detail"] = detailLabel
        
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        masterLabel.font = UIFont.Avenir(size: 16)
        masterLabel.textColor = Colour.charcoal
        masterLabel.textAlignment = .left
        masterLabel.adjustsFontSizeToFitWidth = true
        
        detailLabel.font = UIFont.AvenirMedium(size: 16)
        detailLabel.textColor = Colour.hizentraBlue
        detailLabel.textAlignment = .right
        detailLabel.adjustsFontSizeToFitWidth = true
        detailLabel.numberOfLines = 2
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-16-[master]-0-[detail]-16-|", views: _views)
        _constraints.append(Constraint(item: masterLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0))
        _constraints += Constraint.VFLS("V:|-12-[master]-12-|", views: _views)
        _constraints += Constraint.VFLS("V:|-12-[detail]-12-|", views: _views)
        
        _constraints.activate()
    }
}
