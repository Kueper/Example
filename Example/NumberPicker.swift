//
//  NumberPicker.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

protocol NumberPickerDelegate {
    func didSelect(number: Double)
    func didCancel()
}

class NumberPicker: PlaceholderView {
    
    fileprivate let toolBar = UIToolbar()
    fileprivate let picker = UIPickerView()
    
    var delegate: NumberPickerDelegate?
    
    var style: Style = .decimal //.integer(max: 60) { didSet { self.picker.reloadAllComponents() }}
    
    enum Style {
        case integer(max: Int)
        case decimal
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        print("This view is unfinished!")
        
        _views["picker"] = picker
        _views["toolbar"] = toolBar
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self)
        
        self.backgroundColor = Colour.white
        
        let cancelButton = PlaceholderBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPickerAction(_:)))
        cancelButton.tintColor = Colour.charcoal
        
        let okayButton = PlaceholderBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(okayPickerAction(_:)))
        okayButton.tintColor = Colour.green
        
        toolBar.setItems([cancelButton, okayButton], animated: false)
        toolBar.backgroundColor = Colour.red
        
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = Colour.lightGrey
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // toolbar sits on top of the hizentra bar here...
        _constraints += ["H:|-0-[toolbar]-16-|",
                         "H:[picker(200)]",
                         "V:|-0-[toolbar(44)]-0-[picker(160)]-0-|"]
                        .constraints(on: _views)
        _constraints.append(Constraint(item: picker, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        _constraints.activate()
    }
    
    @objc private func cancelPickerAction(_ sender: Any) {
        delegate?.didCancel()
    }
    
    @objc private func okayPickerAction(_ sender: Any) {
        
        switch style {
        case .integer(_):
            delegate?.didSelect(number: Double(picker.selectedRow(inComponent: 0)))
        case .decimal:
            let number = Double(picker.selectedRow(inComponent: 0)) + (Double(picker.selectedRow(inComponent: 2))/Double(10))
            delegate?.didSelect(number: number)
        }
    }
}

extension NumberPicker: UIPickerViewDelegate {
    

}

extension NumberPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch self.style {
        case .integer(_):
            return 2
        case .decimal:
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch self.style {
        case let .integer(rows):
            // should only be one component
            return component == 0 ? rows : 1
        case .decimal:
            return component == 1 ? 1 : 10
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch style {
        case .integer(_):
            return component == 0 ? String(describing: row + 1) : row == 0 ? "minute" : "minutes"
        case .decimal:
            return component == 1 ? "." : String(describing: row)
        }
    }
}

