//
//  webViewViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 13/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import WebKit

class webViewViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var urlToVisit: String! = ""
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupActivityIndicator()
    }
    
    func setupWebView() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        let url = URL(string: urlToVisit)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.webView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        view.addSubview(activityIndicator)
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func getOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        showActivityIndicator(show: true)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        showActivityIndicator(show: false)
    }
}
