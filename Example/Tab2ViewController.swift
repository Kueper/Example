//
//  Tab2ViewController.swift
//  LifePath
//
//  Created by Eric Kueper on 2017-02-10.
//  Copyright © 2017 Kueper. All rights reserved.
//

import UIKit

class Tab2ViewController: PlaceholderViewController {


    override internal func setupViews() {
        super.setupViews()
        
        let assignableVC = AssignableCardViewController()
        self.addChild(assignableVC, to: self.view)
        
        let propertyVC = EditPropertyViewController()
        assignableVC.child = propertyVC
    }
}
