//
//  UIView+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-06.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func safelyAddSubview(_ _view: UIView) {
        if _view.superview == nil {
            self.addSubview(_view)
        }
    }
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func safelyAddSubviews(_ views: [UIView]) {
        for view in views {
            self.safelyAddSubview(view)
        }
    }
    
    func image() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        self.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

extension InteractiveView where Self: PlaceholderInteractiveView {
    
    func animateViewForTouchesBegan() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.4
        }
    }
    
    func animateViewForTouchesEnded() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
}
