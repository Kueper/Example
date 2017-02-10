//
//  AddNoteViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-23.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit


class AddNoteViewController: BaseButtonViewController {
    
    var note: String?
    var returnNote: ((String?) -> Void)?
    
    internal let segmentedControl = UISegmentedControl()
    internal let label = UILabel()
    internal let textView = UITextView()
    internal let placeholderTextField = UITextField()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["control"] = segmentedControl
        _views["label"] = label
        _views["textView"] = textView
        _views["textField"] = placeholderTextField
        
        textView.addSubview(placeholderTextField)
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self.view)
        
        self.view.backgroundColor = Colour.lightGrey
        
        segmentedControl.tintColor = Colour.hizentraBlue
        segmentedControl.addTarget(self, action: #selector(segmentedControlAction(_:)), for: .valueChanged)
        
        label.textColor = Colour.charcoal
        label.font = UIFont.Avenir(size: 16)
        label.adjustsFontSizeToFitWidth = true
        
        textView.font = UIFont.Avenir(size: 16)
        textView.textColor = Colour.charcoal
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.backgroundColor = Colour.white
        
        placeholderTextField.font = UIFont.Avenir(size: 16)
        placeholderTextField.isUserInteractionEnabled = false
        placeholderTextField.adjustsFontSizeToFitWidth = true
        
        button.setTitle("Done", for: .normal)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += ["H:|-24-[label]-24-|",
                         "H:|-24-[control]-24-|",
                         "H:|-0-[textView]-0-|",
                         "H:|-16-[textField]-16-|",
                         "V:|-24-[label(40)]-12-[control(30)]-20-[textView(>=120)]",
                         "V:|-16-[textField(30)]"]
            .constraints(on: _views)
        _constraints.activate()
    }
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.text = note
        placeholderTextField.isHidden = note != nil && (note?.characters.count ?? 0) > 0
    }
    
    override internal func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note = textView.text
        returnNote?(note)
    }
    
    @objc internal func segmentedControlAction(_ sender: UISegmentedControl) {
        
    }
    
    override internal func baseButtonAction(_ sender: Any?) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UITextViewDelegate
extension AddNoteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderTextField.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderTextField.isHidden = note != nil && (note?.characters.count ?? 0) > 0
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        note = textView.text
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
extension AddNoteViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
