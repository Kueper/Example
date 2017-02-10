//
//  BaseNotificationView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-28.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class BaseNotificationView: PlaceholderInteractiveView {
    
    internal var descriptionLabel = UILabel()
    internal var actionButton = PlaceholderButton()
    
    var mode: Mode = .success { didSet { self.updateView() }}
    
    enum Mode {
        case success
        case failure
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["button"] = actionButton
        _views["label"] = descriptionLabel
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self)
        
        descriptionLabel.textColor = Colour.white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.Avenir(size: 16)
        
        actionButton.setTitle("Dismiss", for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonAction(_:)), for: .touchUpInside)
        
        self.updateView()
    }
    
    fileprivate func updateView() {
        
        switch self.mode {
        case .success:
            self.backgroundColor = Colour.hizentraBlue
            self.actionButton.style = .blue
        case .failure:
            self.backgroundColor = Colour.red
            self.actionButton.style = .white
        }
    }

    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += ["H:|-16-[label]-12-[button(80)]-16-|",
                         "V:|-16-[label]-16-|"].constraints(on: _views)
        _constraints.append(Constraint(item: actionButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        _constraints.activate()
    }
    
    @objc fileprivate func actionButtonAction(_ sender: UIButton) {
        self.action?()
    }
}
