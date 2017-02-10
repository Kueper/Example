//
//  BackingViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-04.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class BackingViewController: PlaceholderViewController {
    
    static let parent = BackingViewController()
    
    fileprivate let loadingScreen = LoadingViewController()

    var pickerDelegate: ImagePickerDelegate?

    
    // Main App VC and Navigation controller
    var mainViewController: MainTabBarController?
    
    func showMainViewController() {
        
        // check if VCs exist yet, init if needed
        mainViewController == nil ? mainViewController = MainTabBarController() : ()
        
        addChild(mainViewController!, to: self.view)
        
    }
    
    func informUser(message: String) {
        
        execute(after: 0, closure: {
            let notification = NotificationPromptViewController()
            notification.notification.descriptionLabel.text = message
            notification.showIn(viewController: nil)
        })
    }
    
    func failureNotification(message: String?) {
        
        execute(after: 0, closure: {
            let notification = NotificationPromptViewController()
            notification.notification.mode = .failure
            notification.notification.descriptionLabel.text = message
            notification.showIn(viewController: nil)
        })
    }
    
    func showLoadingIndicator() {
        
        if self.loadingScreen.parent == nil {
            execute(after: 0, closure: {
                self.loadingScreen.showIn(viewController: nil)
            })
        }
    }
    
    func hideLoadingIndicator() {
        execute(after: 0, closure: {
            self.loadingScreen.close(completion: nil)
        })
    }

    // MARK: VC Transition handler methods
    private func removeViewControllerFromParent(vc: UIViewController?) {
        vc?.removeFromParentViewController()
        vc?.view.removeFromSuperview()
    }
}

protocol ImagePickerDelegate {
    func didPickWith(result: BackingViewController.PickerResult)
}

extension BackingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum PickerResult {
        case cancelled
        case image(_: UIImage)
    }
    
    func presentImagePicker() {
        
        // show appropriate action sheet
        let alert = UIAlertController(title: NSLocalizedString("Choose an option", comment: "Title for action sheet presented to user when selecting images from camera / taking a new picture"), message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "No comment"), style: .cancel, handler: nil)
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: "No comment"), style: .default) { (action) in
            // need to bring up on screen camera here
            
            let cameraVC = InterfaceCameraViewController()
            cameraVC.captureDelegate = self
            (self.pickerDelegate as? UIViewController)?.present(cameraVC, animated: true, completion: nil)
        }
        
        let photosAction = UIAlertAction(title: "Photos", style: .default) { (action) in
            // need to access device photos here
            self.presentPhotoLibrary(type: .photoLibrary)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(photosAction)
        alert.view.tintColor = Colour.hizentraBlue
        
        if let vc = self.pickerDelegate as? UIViewController {
            vc.present(alert, animated: true, completion: { () -> Void in
                alert.view.tintColor = Colour.hizentraBlue
            })
        }
    }
    
    private func presentPhotoLibrary(type: UIImagePickerControllerSourceType) {
        
        // check which type of pic to use
        if UIImagePickerController.isSourceTypeAvailable(type) {
            
            let picker = UIImagePickerController()
            picker.sourceType = type
            picker.allowsEditing = true
            picker.delegate = self
            picker.view.backgroundColor = Colour.white
            (self.pickerDelegate as? UIViewController)?.present(picker, animated: true, completion: nil)
        }
    }
    
    @objc internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerDelegate?.didPickWith(result: .cancelled)
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if picker.sourceType == .photoLibrary {
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                
                self.pickerDelegate?.didPickWith(result: .image(image))
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension BackingViewController: CaptureDelegate {
    
    func didCapture(_ image: UIImage) {
        self.pickerDelegate?.didPickWith(result: .image(image))
    }
    
    func didCancel() {
        // do nothing here, that's coo
        self.pickerDelegate?.didPickWith(result: .cancelled)
    }
}

