//
//  BasePromptViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class BasePromptViewController: PlaceholderPresentableViewController {
    
    internal var promptView = UIView()
    internal var darkenOnPresentation: Bool = true
    internal var tapGesture: UITapGestureRecognizer?
    
    // used to bring view on screen
    fileprivate var promptPositionConstraint = NSLayoutConstraint()
    
    override internal func setupViews() {
        super.setupViews()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeWithoutCompletion))
        tapGesture?.delegate = self
        self.view.addGestureRecognizer(tapGesture!)
        
        _views["promptView"] = promptView
        
        _views.falsifyAutoResizingMaskForViews()
        
        self.view.addSubview(promptView)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // let prompt view determine it's own height by the subviews it adds
        // only control it's position on screen
        _constraints += ["H:|-0-[promptView]-0-|"].constraints(on: _views)
        
        promptPositionConstraint = Constraint(item: promptView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        _constraints.append(promptPositionConstraint)
        _constraints.activate()
    }
    
    @objc override func showIn(viewController: UIViewController?) {
        super.showIn(viewController: viewController)
        
        // set initial conditions
        promptPositionConstraint.constant = 0
        self.view.backgroundColor = darkenOnPresentation ? Colour.charcoal.withAlphaComponent(0.2) : Colour.clear
        self.view.layoutIfNeeded()
        
        // set final view for card
        promptPositionConstraint.constant = -promptView.frame.height
        
        // now animate on the view
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    @objc override func close(completion:(() -> Void)? ) {
        
        // set final view for card
        promptPositionConstraint.constant = 0
        
        // now animate on the view
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                
                self.promptView.layoutIfNeeded()
                self.view.backgroundColor = UIColor.clear
            }, completion: { (completed) in
                if completed == true {
                    super.close(completion: completion)
                }
        })
    }
    
    @objc internal func closeWithoutCompletion() {
        self.close(completion: nil)
    }
}

extension BasePromptViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        return promptView.frame.contains(touch.location(in: self.view)) == false
    }
}
