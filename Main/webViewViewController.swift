//
//  webViewViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 13/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import WebKit

class webViewViewController: UIViewController, WKNavigationDelegate {
    
    var urlToVisit: String! = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let url = URL(string: urlToVisit)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    @IBAction func getOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
