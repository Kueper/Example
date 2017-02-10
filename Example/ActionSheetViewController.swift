//
//  ActionSheetViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-17.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class ActionSheetViewController: BasePromptViewController {

    let actionSheet = ActionSheetView()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["actionSheet"] = actionSheet
        
        _views.falsifyAutoResizingMaskForViews()
        
        self.promptView.addSubview(actionSheet)
        
        actionSheet.checkMarkView.action = {
            self.close(completion: nil)
        }
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // match action sheet to the prompt view
        // let action sheet determine it's own height
        _constraints += Constraint.matchSuper(actionSheet)
        _constraints.activate()
    }
}


