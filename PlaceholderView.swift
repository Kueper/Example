//
//  PlaceholderView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-12.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {

    internal var _views = [String : UIView]()
    internal var _constraints = [NSLayoutConstraint]()
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required override init(frame: CGRect) {
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
        
    }
    
    internal func setupConstraints() {
        
    }
}
