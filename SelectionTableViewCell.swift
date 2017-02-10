//
//  SelectionTableViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-28.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class SelectionTableViewCell: BaseTableViewCell {
    
    internal var selectionView = SelectionCircleView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionView.selected = selected
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["circle"] = selectionView
        
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.isUserInteractionEnabled = false
        
        // make circle the subject of the left view
        self.leftView.addSubview(selectionView)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += ["H:|-16-[circle(30)]-16-|",
                         "V:[circle(30)]"].constraints(on: _views)
        
        // vert align selection view
        _constraints.append(Constraint(item: selectionView, attribute: .centerY, relatedBy: .equal, toItem: leftView, attribute: .centerY, multiplier: 1, constant: 0))
        
        _constraints.activate()
    }
}
