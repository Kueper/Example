//
//  SliderViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class SliderViewController: BasePromptViewController {

    let sliderView = SliderView()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["sliderView"] = sliderView
        
        _views.falsifyAutoResizingMaskForViews()
        
        self.promptView.addSubview(sliderView)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // match action sheet to the prompt view
        // let action sheet determine it's own height
        _constraints += Constraint.matchSuper(sliderView)
        _constraints.activate()
    }
    
    @objc(viewWillAppear:) override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // update the view here
        sliderView.valueChanged(sliderView.slider)
    }
}
