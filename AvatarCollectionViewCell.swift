//
//  AvatarCollectionViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: PlaceholderCollectionViewCell {
    
    let imageView = UIImageView()
    
    override internal func setupViews() {
        super.setupViews()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        Constraint.matchSuperview(imageView)
    }
    
}
