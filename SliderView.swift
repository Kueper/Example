//
//  SliderView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

protocol SliderDelegate {
    func valueChanged(value: Double)
}

class SliderView: PlaceholderPicker {

    let slider = UISlider()
    
    var units: String = "" { didSet { self.unitsLabel.text = self.units }}
    
    fileprivate let valueLabel = UILabel()
    fileprivate let unitsLabel = UILabel()

    var delegate: SliderDelegate?
    
    var numberFormat: NumberFormat = .integer
    
    enum NumberFormat {
        case integer
        case double(decimal: Int)
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["slider"] = slider
        _views["units"] = unitsLabel
        _views["value"] = valueLabel
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: container)
        
        slider.thumbTintColor = Colour.hizentraBlue
        slider.maximumTrackTintColor = Colour.charcoal
        slider.minimumTrackTintColor = Colour.charcoal
        slider.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        
        unitsLabel.textColor = Colour.charcoal
        unitsLabel.font = UIFont.Avenir(size: 18)
        unitsLabel.textAlignment = .right
        unitsLabel.text = units
        
        valueLabel.textColor = Colour.hizentraBlue
        valueLabel.font = UIFont.Avenir(size: 18)
        valueLabel.textAlignment = .left
        valueLabel.text = String(describing: slider.value)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += ["H:[slider(240)]",
                         "V:|-12-[value(40)]",
                         "H:|-40-[units]-6-[value]-40-|",
                         "V:|-12-[units(40)]-12-[slider(40)]-20-|"].constraints(on: _views)
        _constraints.append(Constraint(item: slider, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        _constraints.append(Constraint(item: unitsLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 3))
        _constraints.activate()
    }
    
    @objc internal func valueChanged(_ sender: UISlider) {
        
        switch self.numberFormat {
        case .integer:
            let value = Int(sender.value)
            valueLabel.text = String(describing: value)
            delegate?.valueChanged(value: Double(value))
        case let .double(decimal):
            let factor = 10*decimal.float
            let value = Double((sender.value / factor) * factor)
            valueLabel.text = String(describing: value)
            delegate?.valueChanged(value: value)
        }
    }

}
