//
//  PlaceholderCollectionViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-09.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { return String(describing: self) }
    
    internal var _views = [String : UIView]()
    internal var _constraints = [NSLayoutConstraint]()
    
    internal var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    internal func setupViews() {
        
        _views["label"] = label
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: contentView)
        
        label.textAlignment = .center
        label.font = UIFont.AvenirMedium(size: 14)
        label.adjustsFontSizeToFitWidth = true
    }
    
    internal func setupConstraints() {
        
        _constraints += ["H:|-0-[label]-0-|",
                         "V:|-0-[label]-0-|"]
            .constraints(on: _views)
        _constraints.activate()
    }
}
