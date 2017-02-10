//
//  PlaceholderBarButtonItem.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-14.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderBarButtonItem: UIBarButtonItem {

    //UIBarButtonItem(title: "Export", style: .plain, target: self, action: #selector(rightButtonAction(_:)))

    convenience init(title: String?, style: UIBarButtonItemStyle, target: Any?, action: Selector?) {
        self.init()
        
        self.title = title
        self.style = style
        self.target = target as AnyObject?
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    private func commonInit() {
        let attributes: [String : Any] = [NSFontAttributeName : UIFont.Avenir(size: 16), NSForegroundColorAttributeName : Colour.charcoal]
        self.setTitleTextAttributes(attributes, for: .normal)
    }
}
