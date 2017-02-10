//
//  PlaceholderViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-04.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit
import Foundation

/**
 The parent class that provides initialization methods and properties for all child view controllers
 */
class PlaceholderViewController: UIViewController {
    
    internal var _constraints = [NSLayoutConstraint]()
    internal var _views = [String : UIView]()
    
    override var navigationController: MainNavigationViewController? {
        return super.navigationController as? MainNavigationViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        commonInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Vehicle to have setup views and setup constraints called in every child view controller
    */
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    /**
     Override in every view controller child
     
     Functions:
     - Assign custom views to `_views` dictionary
     - Call `translatesAutoResizingMaskIntoConstraints = false` on each view
     - if adding all views in `_views` dictionary to the view, use `safelyAddSubview()` to ensure
     that any elements already added to the view are not tried to add again
     - do any additional setup for the view elements
     */
    internal func setupViews() {
        self.view.backgroundColor = Colour.white
    }
    
    /**
     Override in every view controller child
     
     - Add constraints to the `_constraints` array
     - Do not override the `_constraints` array
     - Call `activate()` on the array at the end of the implementation
     */
    internal func setupConstraints() {
        
    }
    
    internal func addChild(_ viewController: UIViewController, to view: UIView) {
        
        if viewController.parent == nil {
            self.addChildViewController(viewController)
            view.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            Constraint.matchSuperview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    internal func setNilBackButton() {
        
        let nilBarButtonItem = PlaceholderBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = nilBarButtonItem
    }
}
