//
//  KeyboardDelegates.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-21.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit


/*
  Intended to reduce the code that has to be implemented each time a keyboard is required to come on screen.
 
 Needs to:
 
 conveniently set observer (seems to work)
 
 receive the notification from the observer
 
 parse and format the information, return it to the observer
 
 Somewhat there, although receiving the notification requires this be an objc protocol which creates
 some issues with providing default implementations for every required function.
 
 >>>>>> Not currently ready to use <<<<<<
 */

@objc protocol KeyboardWillChangeFrameDelegate {
    @objc func keyboardWillChange(frame: CGRect, duration: Double, options: UIViewAnimationOptions)
    @objc optional func receiveKeyboard(_ notification: NSNotification)
}


extension KeyboardWillChangeFrameDelegate where Self: UIViewController {
    
    func handle(_ notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
                let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
                
                keyboardWillChange(frame: keyboardSize, duration: duration, options: options)

            }
        }
    }
    
    func setKeyboardObserver() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(self.receiveKeyboard(_:)),
                         name: NSNotification.Name.UIKeyboardWillChangeFrame,
                         object: nil)
        
    }
}

