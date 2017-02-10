//
//  PlaceholderWebViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-06.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A Subclass of PlaceholderViewController that loads the supplied URL on open
 
 Properties:
 - Request: A NSURLRequest
 - completion: A completion block to call for the prompt button - can be used to dismiss the view controller
 */

class PlaceholderWebViewController: PlaceholderViewController {

    fileprivate let webView = UIWebView()
    let promptButton = PlaceholderButton()
    
    // public settable properties
    // customize alert externally
    var request: URLRequest?
    var completion: (() -> Void)?
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["webView"] = webView
        _views["promptButton"] = promptButton
        
        for (_, view) in _views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.view.addSubview(webView)
        self.view.addSubview(promptButton)
        
        webView.delegate = self
        
        promptButton.style = .white        
        promptButton.addTarget(self, action: #selector(promptAction), for: .touchUpInside)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.VFLS("H:|-0-[webView]-0-|", views: _views)
        _constraints += Constraint.VFLS("H:|-0-[promptButton]-0-|", views: _views)
        _constraints += Constraint.VFLS("V:|-0-[webView]-0-[promptButton(44)]-0-|", views: _views)
        _constraints.activate()
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let request = self.request else { return }
        webView.loadRequest(request as URLRequest)
    }
    
    @objc private func promptAction() {
        completion?()
    }
}

extension PlaceholderWebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        
    }
}
