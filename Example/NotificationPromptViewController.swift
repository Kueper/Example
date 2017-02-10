//
//  NotificationPromptViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-28.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class NotificationPromptViewController: BasePromptViewController {

    let notification = BaseNotificationView()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["notification"] = notification
        
        _views.falsifyAutoResizingMaskForViews()
        
        self.promptView.addSubview(notification)
        
        self.darkenOnPresentation = false
        
        tapGesture?.removeTarget(self, action: #selector(closeWithoutCompletion))
        
        notification.action = { [weak self] in
            self?.close(completion: nil)
        }
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // match action sheet to the prompt view
        // let action sheet determine it's own height
        _constraints += Constraint.matchSuper(notification)
        _constraints.activate()
    }
    
    override internal func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        execute(after: 3, closure: { [weak self] in
            self?.close(completion: nil)
        })
    }
}
