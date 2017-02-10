//
//  PlaceholderPresentableViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-28.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderPresentableViewController: PlaceholderViewController {
        
    @objc func showIn(viewController: UIViewController?)  {
        
        // make sure view controller exists
        var _viewController: UIViewController = viewController ?? BackingViewController.parent
        
        // present on top of nav controller if present
        if let nav = _viewController.navigationController { _viewController = nav }
        
        if self.parent == nil {
            _viewController.addChildViewController(self)
            _viewController.view.addSubview(self.view)
            self.view.translatesAutoresizingMaskIntoConstraints = false
            Constraint.matchSuperview(self.view)
            self.willMove(toParentViewController: _viewController)
            self.beginAppearanceTransition(true, animated: true)
        }
    }

    func close(completion: (() -> Void)?) {
        
        self.view.removeFromSuperview()
        self.removeFromParentViewController()

        completion?()
    }
}
