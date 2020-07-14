//
//  profleOtherViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 14/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class profleOtherViewController: UIViewController {
    
    @IBOutlet weak var segmentIndicator: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        segmentIndicator.selectedSegmentIndex = 2
    }

}
