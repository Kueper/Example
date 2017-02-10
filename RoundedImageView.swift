//
//  RoundedImageView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-06.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class RoundedImageView: PlaceholderImageView {
    
    var cornerRadius: CGFloat? { didSet { layoutView() }}

    override func setupViews() {
        super.setupViews()
        
        self.layer.cornerRadius = cornerRadius ?? 0
        self.layer.masksToBounds = true
    }

    private func layoutView() {
        
        self.layer.cornerRadius = cornerRadius ?? 0
        self.setNeedsLayout()
    }
}
