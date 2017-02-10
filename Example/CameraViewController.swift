//
//  CameraViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-14.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

protocol CaptureDelegate {
    func didCapture(_ image: UIImage)
    func didCancel()
}

class CameraViewController: PlaceholderViewController {
        
    internal var captureSession: AVCaptureSession?
    internal var previewLayer = AVCaptureVideoPreviewLayer()
    internal var captureDevice: AVCaptureDevice?
    internal var deviceInput: AVCaptureDeviceInput?
    
    override internal func setupViews() {
        super.setupViews()
        
        self.view.backgroundColor = Colour.lightGrey
        
        configureCamera()
    }
    
    override internal func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.previewLayer.frame = self.view.frame
    }

    override internal func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        captureSession?.stopRunning()
    }

    // only called on the VDL thread
    fileprivate func configureCamera() {
        
        if checkCameraAuthorization() == false {
            print("Need to inform user to set camera permissions")
            
            // end the thread
            return
        }
        
        if Platform.isSimulator == true {
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPresetMedium
        
        setDevice(position: .back)
    }
    
    internal func setDevice(position: AVCaptureDevicePosition) {
        let device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: position)
        
        if device?.hasMediaType(AVMediaTypeVideo) == true {
            if device?.position == position {
                captureDevice = device
                beginSession()
            }
        }
    }

    // still only called on VDL thread
    internal func beginSession() {
        
        // remove any existing input
        captureSession?.removeInput(deviceInput)
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)

            // add the new input
            if captureSession?.canAddInput(deviceInput) == true {
                captureSession?.addInput(deviceInput)
            }
        }
        catch {
            print("error: \(error.localizedDescription)")
            return
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer.frame = UIScreen.main.bounds
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.insertSublayer(previewLayer, at: 0)
        
        captureSession?.startRunning()
    }
    
    @objc private func cameraButtonAction(sender: UIButton) {
        
    }
    
    fileprivate func checkCameraAuthorization() -> Bool {
        
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        switch status {
        case .authorized:
            return true
        case .denied:
            return false
        case .notDetermined:
            // no longer need to manually request access here
            // the device system will formally ask with plist string
            // when the capture device is created
            return true
        case .restricted:
            return false
        }
        
    }
}
