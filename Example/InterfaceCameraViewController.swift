//
//  InterfaceCameraViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2017-01-03.
//  Copyright © 2017 Softprint. All rights reserved.
//

import UIKit
import AVFoundation

class InterfaceCameraViewController: CameraViewController {
    
    internal let captureButton: UIButton = UIButton()
    internal let switchCameraButton: UIButton = UIButton()
    internal let imageView: UIImageView = UIImageView()
    internal let acceptButton:CheckMarkView = CheckMarkView()
    internal let retakeButton: ArrowView = ArrowView(direction: .left)
    internal let imageBackView: UIView = UIView()
    
    var captureDelegate: CaptureDelegate?
    
    internal var stillImageOutput = AVCapturePhotoOutput()
    
    var state: State = .back { didSet { updateCameraInput() }}
    
    enum State: Toggleable {
        case front
        case back
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["captureButton"] = captureButton
        _views["switchButton"] = switchCameraButton
        _views["imageView"] = imageView
        _views["imageBackView"] = imageBackView
        _views["checkMark"] = acceptButton
        _views["arrowView"] = retakeButton
        
        imageBackView.addSubview(imageView)
        imageBackView.safelyAddSubviews([retakeButton, acceptButton])
        
        self.view.safelyAddSubviews([switchCameraButton, captureButton])
        self.view.addSubview(imageBackView)
        
        _views.falsifyAutoResizingMaskForViews()
        
        switchCameraButton.setImage(UIImage(named: "cam_flip"), for: .normal)
        switchCameraButton.addTarget(self, action: #selector(alternateCamera), for: .touchUpInside)
        
        let circleView = CircleView()
        circleView.fill = true
        circleView.fillColour = Colour.white
        circleView.borderColour = Colour.hizentraBlue
        circleView.borderWidth = 5.cgFloat
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.isUserInteractionEnabled = false
        
        captureButton.addSubview(circleView)
        Constraint.matchSuperview(circleView)
        captureButton.addTarget(self, action: #selector(captureStillImage), for: .touchUpInside)
        
        // hide image view on setup
        imageView.contentMode = .scaleAspectFit
        
        imageBackView.backgroundColor = Colour.charcoal
        imageBackView.isHidden = true
        
        retakeButton.backgroundColor = Colour.clear
        retakeButton.action = {
            self.retakeImage()
        }
        
        acceptButton.backgroundColor = Colour.clear
        acceptButton.action = {
            self.acceptImage()
        }
        
        acceptButton.strokeColour = Colour.hizentraBlue
        acceptButton.startDrawn = true
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += ["H:[captureButton(50)]",
                         "V:[captureButton(50)]-20-|",
                         "H:|-30-[switchButton(30)]",
                         "V:|-30-[switchButton(30)]",
                         // image view views
                        "H:|-0-[imageView]-0-|",
                        "H:|-0-[imageBackView]-0-|",
                        "V:|-0-[imageBackView]-0-|",
                        "H:|-20-[arrowView(20)]",
                        "V:[arrowView(30)]-20-|",
                        "H:[checkMark(40)]-20-|",
                        "V:[checkMark(40)]-20-|"].constraints(on: _views)
        _constraints.append(Constraint(item: captureButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        _constraints.append(Constraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: imageBackView, attribute: .centerY, multiplier: 1, constant: 0))
        _constraints.activate()
    }
    
    override internal func beginSession() {
        
        super.beginSession()
        
        captureSession?.sessionPreset = AVCaptureSessionPresetPhoto
        
        // add output, may be called more than once, so protect against multiple calls
        if captureSession?.canAddOutput(stillImageOutput) == true {
            captureSession?.addOutput(stillImageOutput)
        }
    }
    
    @objc internal func captureStillImage() {
        
        // check connection
        if stillImageOutput.connection(withMediaType: AVMediaTypeVideo) != nil {
            
            // create settings
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecJPEG])
            
            // request image
            stillImageOutput.capturePhoto(with: settings, delegate: self)
        }
    }
    
    @objc internal func alternateCamera() {
        self.state.toggle()
    }
    
    fileprivate func updateCameraInput() {
        
        switch self.state {
        case .back:
            captureSession?.stopRunning()
            setDevice(position: .back)
        case .front:
            captureSession?.stopRunning()
            setDevice(position: .front)
        }
    }
    
    internal func retakeImage() {
        self.imageBackView.isHidden = true
    }
    
    internal func acceptImage() {
        // return the UI here, delegate already has the image
        self.dismiss(animated: true, completion: nil)
    }
}

extension InterfaceCameraViewController: AVCapturePhotoCaptureDelegate {
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        
        if let sampleBuffer = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: nil) {
            
            if let image = UIImage(data: dataImage) {
                
                execute(after: 0, closure: { [weak self] in
                    
                    if let _self = self {
                        
                        // configure image view
                        _self.imageBackView.isHidden = false
                        _self.imageView.image = image
                        
                        // send the image to the delegate
                        _self.captureDelegate?.didCapture(image)
                    }
                })
            }
        }
        
    }
}
