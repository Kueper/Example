//
//  UIButton+Extensions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-12.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColour(_ colour: UIColor, for controlState: UIControlState) {
        let background = UIView(frame: CGRect(x:0, y:0, width: 1, height: 1))
        background.backgroundColor = colour
        self.setBackgroundImage(background.image(), for: controlState)
    }
}
