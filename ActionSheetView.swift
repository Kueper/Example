//
//  ActionSheetView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class ActionSheetView: PlaceholderPicker {
    
    fileprivate var sections: [Section] = [] { didSet { updateSections() }}
    fileprivate var buttons: [Button] = []
    
    fileprivate var buttonConstraints = [NSLayoutConstraint]()
    
    override internal func setupViews() {
        super.setupViews()
        
        self.backgroundColor = Colour.white
    }
    
    private func updateSections() {
        // kill existing constraints
        buttonConstraints.deactivate(); buttonConstraints = []
        
        // kill existing buttons
        buttons.forEach({ (button) in
            button.removeFromSuperview()
        })
        
        buttons = []
        
        // create new buttons
        sections.enumerated().forEach({ (index, section) in
            // add buttons
            let newButton = Button()
            newButton.label.text = section.title
            newButton.index = index
            newButton.translatesAutoresizingMaskIntoConstraints = false
            newButton.circle.selected = section.selected
            newButton.action = section.action
            self.container.addSubview(newButton)
            
            buttons.append(newButton)
        })
        
        // add buttons to the view
        buttons.forEach { (button) in
            // add to superView
            
            // buttons are 30 tall + 4 offset from the title label
            let vertOffset = (button.index ?? 0)*40
            
            buttonConstraints += Constraint.VFLS("H:|-0-[button]-0-|", views: ["button" : button])
            
            // make this work regardless of title label being in position
            // this code can be called before the load view cycle
            // the vert offset anticipated by the title label and buffers is 38 pts vertically
            // reflected in the vertical offset
            if button.index == buttons.count - 1 {
                // last button
                buttonConstraints += Constraint.VFLS("V:|-\(vertOffset)-[button(40)]-10-|", views: ["button" : button, "title" : barButton])
            } else {
                buttonConstraints += Constraint.VFLS("V:|-\(vertOffset)-[button(40)]", views: ["button" : button, "title" : barButton])
            }
        }
        
        buttonConstraints.activate()
    }
    
    // MARK: Public functions to set up the action sheet
    func addSection(title: String, selected: Bool, action: (() -> Void)?) {
        self.sections.append(Section(title: title, action: action, selected: selected))
    }
}

extension ActionSheetView {
    
    internal class Section {
        
        var title: String
        var action: (() -> Void)?
        var selected: Bool = false
        
        init(title: String, action: (() -> Void)?, selected: Bool) {
            self.title = title
            self.action = action
            self.selected = selected
        }
    }
}

extension ActionSheetView {
    
    internal class Button: PlaceholderInteractiveView {
        
        var index: Int?
        var label = UILabel()
        var circle = SelectionCircleView()
        
        override internal func setupViews() {
            super.setupViews()
            
            _views["label"] = label
            _views["circle"] = circle
            
            _views.forEach { (_, view) in
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
            }
            
            circle.isUserInteractionEnabled = false
            
            label.font = UIFont.Avenir(size: 16)
            label.textColor = Colour.charcoal
            label.adjustsFontSizeToFitWidth = true
            label.isUserInteractionEnabled = false
        }
        
        override internal func setupConstraints() {
            super.setupConstraints()
            
            _constraints += Constraint.VFLS("H:|-16-[circle(20)]-16-[label]-16-|", views: _views)
            _constraints += Constraint.VFLS("V:|-4-[label]-4-|", views: _views)
            _constraints += Constraint.VFLS("V:[circle(20)]", views: _views)
            _constraints.append(Constraint(item: circle, attribute: .centerY, relatedBy: .equal, toItem: label, attribute: .centerY, multiplier: 1, constant: 0))
            _constraints.activate()
        }
        
        override internal func executeAction() {
            super.executeAction()
            self.circle.selected = !self.circle.selected
        }
    }
}
