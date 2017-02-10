//
//  PlaceholderImageView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-06.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderImageView: UIImageView {

    internal var _views = [String : UIView]()
    internal var _constraints = [NSLayoutConstraint]()
    
    var rounded: Bool = false { didSet { self.setRounded() }}
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required override init(image: UIImage?) {
        super.init(image: image)
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
    
    override internal func layoutSubviews() {
        super.layoutSubviews()
        
        self.setRounded()
    }
    
    fileprivate func setRounded() {
        self.layer.cornerRadius = self.rounded ? min(self.frame.size.width, self.frame.size.height)/2 : 0
        self.layer.masksToBounds = self.rounded
        self.setNeedsDisplay()
    }
}
