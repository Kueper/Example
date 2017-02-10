//
//  EditPropertyViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-11.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A view controller that provides an interface to edit properties conveniently over a page.

*/
class EditPropertyViewController: PlaceholderViewController {
    
    internal var textField = UITextField()
    internal var doneButton = PlaceholderButton()
    internal var cancelButton = PlaceholderButton()
    internal var label = UILabel()
    internal var underline = UIView()
    
    // setable properties to return the value from the card
    var property: Any?
    var returnWith: ((Any?) -> Void)?
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["textField"] = textField
        _views["doneButton"] = doneButton
        _views["label"] = label
        _views["underline"] = underline
        _views["cancelButton"] = cancelButton
        
        _views.forEach { (_, view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        self.view.backgroundColor = Colour.white
        
        label.font = UIFont.Avenir(size: 18)
        label.textColor = Colour.charcoal
        label.numberOfLines = 0
        label.textAlignment = .center
        
        doneButton.style = .blue
        doneButton.borderStyle = .round
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonAction(_:)), for: .touchUpInside)
        
        textField.font = UIFont.Avenir(size: 16)
        textField.delegate = self
        
        underline.backgroundColor = Colour.hizentraBlue
        
        cancelButton.style = .white
        cancelButton.borderStyle = .none
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-30-[textField]-30-|", views: _views)
        _constraints += Constraint.VFLS("H:|-30-[underline]-30-|", views: _views)
        _constraints += Constraint.VFLS("H:|-30-[label]-30-|", views: _views)
        _constraints += Constraint.VFLS("H:[cancelButton(100)]-12-[doneButton(100)]", views: _views)
        _constraints += Constraint.VFLS("V:[label]-30-[textField(40)]-0-[underline(1)]", views: _views)
        _constraints += Constraint.VFLS("V:[doneButton(40)]-20-|", views: _views)
        _constraints += Constraint.VFLS("V:[cancelButton(40)]-20-|", views: _views)
        
        let centerConstraint = Constraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        centerConstraint.priority = 500
        _constraints.append(centerConstraint)
        
        _constraints.append(Constraint(item: doneButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 6))
        
        _constraints.activate()
    }
    
    @objc internal func doneButtonAction(_ sender: Any?) {
        textField.resignFirstResponder()
        
        returnWith?(property)
        
        if let parent = self.parent as? AssignableCardViewController {
            // temporarily disable
            parent.close(completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc internal func cancelButtonAction(_ sender: Any?) {
        if let parent = self.parent as? AssignableCardViewController {
            parent.close(completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension EditPropertyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.property = textField.text
        textField.resignFirstResponder()
        return true
    }
}
