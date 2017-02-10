//
//  CardViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-11.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

protocol CardViewControllerTapGestureDelegate {
    func tapGestureAction(sender: UIViewController)
}

class CardViewController: PlaceholderPresentableViewController {
    
    internal var card = UIView()
    
    private var gestureLayer = UIView()
    
    private var maskPath: UIBezierPath?
    
    internal var maskLayer: CAShapeLayer?
    internal var borderLayer: CAShapeLayer?
    internal var gradientLayer = CAGradientLayer()
    
    private var maskSet: Bool { return maskPath != nil }
    private var borderSet: Bool { return borderLayer != nil }
    private var gradientSet: Bool = false
    
    private var radius: CGFloat?
    private var topOnly: Bool = false
    
    fileprivate var vertCardConstraint = NSLayoutConstraint()
    fileprivate var cardHeightConstraint = NSLayoutConstraint()
    
    var heightFactor: CGFloat = 0.6 {
        willSet {
            if newValue > 1.0 {
                self.heightFactor = 1.0
            }
            
            if newValue < 0.0 {
                self.heightFactor = 0.0
            }
            
        }
        
        didSet {
            cardHeightConstraint = Constraint(item: card, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: self.heightFactor, constant: 0)
            [cardHeightConstraint].activate()
            self.card.layoutIfNeeded()
        }
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["card"] = card
        _views["gestureLayer"] = gestureLayer
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeByGesture(_:)))
        gestureLayer.addGestureRecognizer(tapGesture)
        gestureLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gestureLayer)
        
        card.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(card)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-0-[gestureLayer]-0-|", views: _views)
        _constraints += Constraint.VFLS("V:|-0-[gestureLayer]-0-|", views: _views)
        
        _constraints += Constraint.VFLS("H:|-30-[card]-30-|", views: _views)
        
        cardHeightConstraint = Constraint(item: card, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: heightFactor, constant: 0)
        
        vertCardConstraint = Constraint(item: card, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -UIScreen.main.bounds.height*0.8)
        
        _constraints.append(vertCardConstraint)
        _constraints.append(cardHeightConstraint)
        
        _constraints.activate()
    }
    
    @objc override func showIn(viewController: UIViewController?) {
        super.showIn(viewController: viewController)
        
        // set initial conditions
        vertCardConstraint.constant = 0
        self.view.backgroundColor = Colour.charcoal.withAlphaComponent(0.2)
        self.view.layoutIfNeeded()
        
        // set final view for card
        vertCardConstraint.constant = -(self.view.frame.size.height/2 + self.view.frame.size.height*0.3)
                
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
        vertCardConstraint.constant = 0
        
        // notify self of the appearance transition
        self.beginAppearanceTransition(false, animated: true)

        // now animate on the view
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                
                self.view.layoutIfNeeded()
                self.view.backgroundColor = UIColor.clear
            }, completion: { (completed) in
                if completed == true {
                    super.close(completion: completion)
                }
        })
    }
    
    private func setMaskWith(radius: CGFloat, topOnly: Bool) {
        
        self.radius = radius
        
        let left = CGFloat(0) //self.testContainer.frame.origin.x
        let right = self.card.frame.width
        let top = CGFloat(0) //self.testContainer.frame.origin.y
        let bottom = self.card.frame.height
        
        maskPath = UIBezierPath()
        // move to left side, just below top by radius
        maskPath?.move(to: CGPoint(x: left, y: top + radius))
        
        switch topOnly {
        case true:
            // connect down left side, across bottom
            maskPath?.addLine(to: CGPoint(x: left, y: bottom))
            maskPath?.addLine(to: CGPoint(x: right, y: bottom))
        case false:
            
            // this could be done using layer.cornerRadius
            // but for consistency with the "true" case it is
            // implemented with the mask
            
            // connect down left side, across bottom
            maskPath?.addLine(to: CGPoint(x: left, y: bottom-radius))
            // put in bottom left corner
            maskPath?.addArc(withCenter: CGPoint(x: left + radius, y: bottom - radius), radius: radius, startAngle: -CGFloat.pi, endAngle: -CGFloat(3*M_PI_2), clockwise: false)
            //            bezPath.addLineToPoint(CGPoint(x: left+radius, y: bottom))
            maskPath?.addLine(to: CGPoint(x: right-radius, y: bottom))
            // put in bottom right corner
            maskPath?.addArc(withCenter: CGPoint(x: right - radius, y: bottom - radius), radius: radius, startAngle: -CGFloat(3*M_PI_2), endAngle: 0, clockwise: false)
            //            bezPath.addLineToPoint(CGPoint(x: right, y: bottom-radius))
        }
        
        // add line to right side, just below top by radius
        maskPath?.addLine(to: CGPoint(x: right, y: top + radius))
        // top right corner
        maskPath?.addArc(withCenter: CGPoint(x: right - radius, y: top + radius), radius: radius, startAngle: 0, endAngle: -CGFloat(M_PI_2), clockwise: false)
        maskPath?.addLine(to: CGPoint(x: left + radius, y: top))
        // top left corner
        maskPath?.addArc(withCenter: CGPoint(x: left + radius, y: top + radius), radius: radius, startAngle: -CGFloat(M_PI_2), endAngle: -CGFloat.pi, clockwise: false)
        maskPath?.close()
        
        maskLayer?.removeFromSuperlayer()
        maskLayer = CAShapeLayer()
        maskLayer?.path = maskPath!.cgPath
        self.card.layer.mask = maskLayer
    }
    
    internal func setMaskWith(radius: CGFloat) {
        self.topOnly = false
        setMaskWith(radius: radius, topOnly: false)
    }
    
    internal func setTopMaskWith(radius: CGFloat) {
        self.topOnly = true
        setMaskWith(radius: radius, topOnly: true)
    }
    
    internal func addBorder(width: CGFloat, colour: UIColor) {
        
        if maskSet == true {
            borderLayer?.removeFromSuperlayer()
            borderLayer = CAShapeLayer()
            borderLayer?.path = self.maskPath?.cgPath
            borderLayer?.lineWidth = width
            borderLayer?.strokeColor = colour.cgColor
            borderLayer?.fillColor = UIColor.clear.cgColor
            self.card.layer.addSublayer(borderLayer!)
        } else {
            self.card.layer.borderColor = colour.cgColor
            self.card.layer.borderWidth = width
        }
    }
    
    internal func addShadow() {
        
        gradientSet = true
        
        if gradientLayer.superlayer == nil { self.view.layer.insertSublayer(gradientLayer, at: 0) }
        
        let proportion = CGFloat(40) / self.view.frame.size.height
        gradientLayer.startPoint  = CGPoint(x: 0.5, y: 1-proportion)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = [Colour.white, Colour.shadowGrey].map({$0.cgColor})
        gradientLayer.frame = self.view.frame
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if gradientSet == true {
            addShadow()
        }
        
        if maskSet == true {
            guard let radius = radius else { return }
            setMaskWith(radius: radius, topOnly: topOnly)
        }
        
        if borderSet == true {
            addBorder(width: borderLayer!.lineWidth, colour: UIColor.init(cgColor: borderLayer!.strokeColor!))
        }
    }
    
    @objc private func closeByGesture(_ sender: UITapGestureRecognizer?) {
        self.close(completion: nil)
    }
}
