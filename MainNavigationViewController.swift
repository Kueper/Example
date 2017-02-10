//
//  MainNavigationViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-05.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    private var barView = UIView()
    
    internal var _views = [String : UIView]()
    internal var _constraints = [NSLayoutConstraint]()

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    internal func setupViews() {
        self.navigationBar.isTranslucent = false

        _views["bar"] = barView
        
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.navigationBar.addSubview(barView)
        }
        
        barView.backgroundColor = Colour.hizentraBlue
        self.navigationBar.tintColor = Colour.hizentraBlue
    }
    
    internal func setupConstraints() {
        
        _constraints += Constraint.VFLS("H:|-0-[bar]-0-|", views: _views)
        _constraints += Constraint.VFLS("V:[bar(2)]-0-|", views: _views)
        _constraints.activate()
    }
}
