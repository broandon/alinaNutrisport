//
//  baseURL.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 28/04/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class HTTPViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func baseURL() -> String {
        let URLString = "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php"
        return URLString
    }
}
