//
//  AssignableCardViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-11.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class AssignableCardViewController: DragableCardViewController {
    
    var child: PlaceholderViewController? { didSet { addChildViewControllerToView() }}
    
    override internal func setupViews() {
        super.setupViews()
        
        self.setMaskWith(radius: 20)
        self.addBorder(width: 3, colour: Colour.hizentraBlue)
    }
    
    private func addChildViewControllerToView() {
        guard
            let _childVC = child
            else { return }
        
        if _childVC.parent == nil {
            
            self.addChild(_childVC, to: self.card)
        }
    }
    
    override internal func close(completion: (() -> Void)?) {
        // need some special handling for the child VC
        
        self.child?.willMove(toParentViewController: nil)
        super.close(completion: completion)
    }
}

// implement on the VC you want to make the DragableCardDelegate

//extension <ViewController>: DragableCardDelegate {
//
//    func cardMovedToPosition(point: CGPoint) {
//        guard let view = <dragableCardVC>?.view else { return }
//
//        let difference = abs(view.center.y - startingPoint.y)
//        let halfHeight = self.view.frame.size.height/2
//        let factor = 1 - (difference/halfHeight)
//
//        view.center = CGPoint(x: view.center.x + (point.x * factor), y: view.center.y + (point.y * factor))
//    }
//
//    func panGestureChangedState(state: UIGestureRecognizerState) {
//        guard let view = <dragableCardVC>?.view else { return }
//
//        switch state {
//        case .Ended:
//
//            UIView.animateWithDuration(0.7,
//                                       delay: 0,
//                                       usingSpringWithDamping: 0.78,
//                                       initialSpringVelocity: 0.35,
//                                       options: .CurveEaseOut,
//                                       animations: {
//                                        view.frame.origin = CGPointZero
//                }, completion: nil)
//
//        case .Began:
//            startingPoint = view.center
//        default: break
//        }
//    }
//}
