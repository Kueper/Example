//
//  PlaceholderButton.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-12.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderButton: UIButton {

    enum Style {
        case blue
        case white
    }
    
    enum BorderStyle {
        case roundWhite
        case roundBlue
        case round
        case white
        case none
    }
    
    // setable views
    var borderStyle: BorderStyle = .none { didSet { updateViews() }}
    var style: Style = .blue { didSet { updateViews() }}

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        updateViews()
    }
    
    private func updateViews() {
        switch self.style {
        case .blue:
            self.setTitleColor(Colour.lightGrey, for: .normal)
            self.setBackgroundColour(Colour.hizentraBlue, for: .normal)
                        
            // highlighted
            self.setBackgroundColour(Colour.hizentraShadowBlue, for: .highlighted)
            
            // indicate disabled with grey button background colour
            self.setTitleColor(Colour.shadowGrey, for: .disabled)
            self.setBackgroundColour(Colour.lightGrey, for: .disabled)
        case .white:
            self.setTitleColor(Colour.hizentraBlue, for: .normal)
            self.setBackgroundColour(Colour.white, for: .normal)
            
            // highlighted
            self.setBackgroundColour(Colour.lightGrey, for: .highlighted)
            self.setTitleColor(Colour.charcoal, for: .highlighted)

            // indicate disabled with grey title colour
            self.setTitleColor(Colour.shadowGrey, for: .disabled)
            self.setBackgroundColour(Colour.lightGrey, for: .disabled)
        }
        
        switch self.borderStyle {
        case .round:
            self.layer.borderColor = nil
            self.layer.borderWidth = 0
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
        case .roundWhite:
            self.layer.borderColor = Colour.white.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
        case .roundBlue:
            self.layer.borderColor = Colour.hizentraBlue.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
        case .white:
            self.layer.borderColor = Colour.white.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 0
        case .none:
            self.layer.borderColor = nil
            self.layer.borderWidth = 0
            self.layer.cornerRadius = 0
        }
    }
}
