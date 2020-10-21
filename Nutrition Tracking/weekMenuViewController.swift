//
//  weekMenuViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 16/10/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import WebKit

class weekMenuViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var urlToVisit: String! = ""
    var activityIndicator: UIActivityIndicatorView!
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        //  setupWebView()
        setupActivityIndicator()
    }
    
    func getInfo() {
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getWeekMenu&id_user="+UserID!
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("error: No data to decode")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            
            if let dictionary = json {
                print(dictionary)
                if let data = dictionary["data"] as? Dictionary<String, Any> {
                    print(data)
                    if let dietaSemanal = data["dieta_semanal"] as? Dictionary<String, Any> {
                        let urlForWeeklyDiet = dietaSemanal["url"]
                        self.urlToVisit = urlForWeeklyDiet as? String
                        self.setupWebView(theURL: self.urlToVisit)
                    }
                }
            }
            
        }
        task.resume()
    }
    
    
    func setupWebView(theURL: String) {
        DispatchQueue.main.async {
            self.webView.navigationDelegate = self
            self.webView.uiDelegate = self
            let url = URL(string: theURL)!
            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
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
