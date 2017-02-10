//
//  MainTabBarController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-05.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 The view controller parent that handles the main body of the application
 
 Main View Controller is a TabBarController that holds references to the different
 main tabs of the app
 */
class MainTabBarController: UITabBarController {
    
    
    private let listVC = ListViewController()
    
    private let cardVC = Tab2ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraint()
    }
    
    internal func setupViews() {
        self.setViewControllers([listVC, cardVC], animated: true)
        
        self.tabBar.isTranslucent = false
        self.tabBar.items?[0].title = NSLocalizedString("List", comment: "First tab bar icon title")
        self.tabBar.items?[1].title = NSLocalizedString("Card example", comment: "Second tab bar icon title")

    }
    
    internal func setupConstraint() {
        
    }
        
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        switch self.selectedIndex {
        case 0:
            break
        default:
            break
        }
        
    }
}
