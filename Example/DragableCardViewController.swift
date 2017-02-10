//
//  DragableCardViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-18.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

protocol DragableCardDelegate {
    func cardMovedToPosition(point: CGPoint)
    func panGestureChangedState(state: UIGestureRecognizerState)
    var startingPoint: CGPoint { get set }
}

class DragableCardViewController : CardViewController, DragableCardDelegate {
    
    internal var startingPoint: CGPoint = CGPoint.zero

    private var dragGesture = UIPanGestureRecognizer()
    private var state: UIGestureRecognizerState?
    
    override internal func setupViews() {
        super.setupViews()
        
        dragGesture = UIPanGestureRecognizer(target: self, action: #selector(receivePanGesture(_:)))
        self.card.addGestureRecognizer(dragGesture)
    }
    
    @objc private func receivePanGesture(_ sender: UIPanGestureRecognizer) {
        
        if sender.state != self.state {
            self.state = sender.state
            self.panGestureChangedState(state: sender.state)
        }
        
        self.cardMovedToPosition(point: sender.translation(in: card))
        sender.setTranslation(CGPoint.zero, in: card)
    }
    
    func cardMovedToPosition(point: CGPoint) {

        let difference = abs(card.center.y - startingPoint.y)
        let halfHeight = card.frame.size.height/2
        let factor = 1 - (difference/halfHeight)

        card.center = CGPoint(x: card.center.x + (point.x * factor), y: card.center.y + (point.y * factor))
    }

    func panGestureChangedState(state: UIGestureRecognizerState) {

        switch state {
        case .ended:

            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.78,
                           initialSpringVelocity: 0.35,
                           options: .curveEaseOut,
                           animations: {
                                        
                            self.card.center = self.startingPoint
                            
                }, completion: nil)

        case .began:
            startingPoint = card.center
        default: break
        }
    }
    
}
