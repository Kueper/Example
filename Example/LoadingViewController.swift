//
//  LoadingViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2017-01-25.
//  Copyright © 2017 Softprint. All rights reserved.
//

import UIKit

class LoadingViewController: PlaceholderPresentableViewController {

    fileprivate let indicator = UIActivityIndicatorView()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["indicator"] = indicator
        
        _views.falsifyAutoResizingMaskForViews()
        self.view.addSubview(indicator)
        
        self.view.isUserInteractionEnabled = false
        self.view.backgroundColor = Colour.clear
        
        indicator.tintColor = Colour.hizentraBlue
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += ["H:[indicator(30)]",
                         "V:[indicator(30)]"].constraints(on: _views)
        _constraints.append(Constraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        _constraints.append(Constraint(item: indicator, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        _constraints.activate()
    }
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        indicator.startAnimating()
    }
    
    override internal func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        indicator.stopAnimating()
    }
    
    @objc override func showIn(viewController: UIViewController?) {
        super.showIn(viewController: viewController)
        
        // set initial conditions
        self.view.backgroundColor = Colour.clear
        self.view.alpha = 0
        
        // now animate on the view
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: .curveEaseOut,
            animations: {

                self.view.backgroundColor = Colour.charcoal.withAlphaComponent(0.2)
                self.view.alpha = 1
                
        }, completion: nil)
    }
    
    @objc override func close(completion:(() -> Void)? ) {
        
        // now animate on the view
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                
                self.view.alpha = 0
                self.view.backgroundColor = UIColor.clear
                
        }, completion: { (completed) in
            if completed == true {
                super.close(completion: completion)
            }
        })
    }
}
