//
//  PlaceholderPageViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2017-01-12.
//  Copyright © 2017 Softprint. All rights reserved.
//

import UIKit

class PlaceholderPageViewController: UIPageViewController {
    
    internal var _constraints = [NSLayoutConstraint]()
    internal var _views = [String : UIView]()
    internal var nextIndex: Int = 0
    
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
}
