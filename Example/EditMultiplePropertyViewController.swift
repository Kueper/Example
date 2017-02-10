//
//  EditMultiplePropertyViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2017-01-03.
//  Copyright © 2017 Softprint. All rights reserved.
//

import UIKit

class EditMultiplePropertyViewController: EditPropertyViewController {
    
    internal var titleLabel: UILabel = UILabel()
    
    internal var subtitleLabel: UILabel = UILabel()
    
    internal var textViewLabel: UILabel = UILabel()
    internal var textView: UITextView = UITextView()
    internal var overlayTextField: UITextField = UITextField()
    
    internal var chevron: ArrowView = ArrowView(direction: .down)
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["textViewLabel"] = textViewLabel
        _views["textView"] = textView
        _views["overlayTextField"] = overlayTextField
        _views["subtitle"] = subtitleLabel
        _views["title"] = titleLabel
        _views["chevron"] = chevron
        
        textView.addSubview(overlayTextField)
        textField.addSubview(chevron)
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self.view)
        
        subtitleLabel.textColor = Colour.charcoal
        subtitleLabel.font = UIFont.Avenir(size: 16)
        subtitleLabel.numberOfLines = 0
        
        textViewLabel.textColor = Colour.charcoal
        textViewLabel.font = UIFont.Avenir(size: 14)
        textViewLabel.adjustsFontSizeToFitWidth = true
        textViewLabel.numberOfLines = 0
        
        textView.textColor = Colour.charcoal
        textView.delegate = self
        textView.backgroundColor = Colour.lightGrey
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        textView.delegate = self
        textView.returnKeyType = .done
        
        overlayTextField.backgroundColor = UIColor.clear
        overlayTextField.isUserInteractionEnabled = false
        
        chevron.fill = true
        chevron.tintColor = Colour.hizentraBlue
        chevron.isUserInteractionEnabled = false
        chevron.backgroundColor = Colour.clear
        
        textField.backgroundColor = Colour.lightGrey
        textField.borderStyle = .none
        textField.textAlignment = .justified
        // one line solution to offset text rect
        // alternatively, subclass and override the text rect methods
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(4, 0, 0)
        
        label.textAlignment = .left
        label.font = UIFont.Avenir(size: 14)
        
        underline.isHidden = true
        
        titleLabel.font = UIFont.AvenirMedium(size: 20)
        titleLabel.textColor = Colour.hizentraBlue
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-4-[title]-0-|", views: _views)
        
        _constraints += Constraint.VFLS("H:|-4-[overlayTextField]-0-|", views: _views)
        _constraints += Constraint.VFLS("V:|-4-[overlayTextField]", views: _views)
        
        _constraints += Constraint.VFLS("H:|-30-[textViewLabel]-30-|", views: _views)
        _constraints += Constraint.VFLS("H:|-30-[textView]-30-|", views: _views)
        _constraints += Constraint.VFLS("H:|-30-[subtitle]-30-|", views: _views)
        
        _constraints += ["H:[chevron(16)]-12-|",
                         "V:[chevron(12)]"].constraints(on: _views)
        
        _constraints.append(Constraint(item: chevron, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1, constant: 0))
        
        _constraints += Constraint.VFLS("V:[title]-10-[subtitle]-12-[label]-0-[textField]-20-[textViewLabel]-0-[textView(60)]", views: _views)
        let centerConstraint = Constraint(item: textViewLabel, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        _constraints.append(centerConstraint)
        
        _constraints.activate()
    }
    
}

// MARK: UITextViewDelegate
extension EditMultiplePropertyViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        overlayTextField.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        overlayTextField.isHidden = textView.text != nil
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}

// MARK: UITextFieldDelegate
extension EditMultiplePropertyViewController {
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
