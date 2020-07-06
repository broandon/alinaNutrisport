//
//  profileViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 05/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
    
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        profileImage.layer.backgroundColor = UIColor.white.cgColor
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.layer.borderWidth = 0.0
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.layer.masksToBounds = true
        profileImage.layer.shadowRadius = 3.5
        profileImage.layer.shadowColor = UIColor.gray.cgColor
        profileImage.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        profileImage.layer.shadowOpacity = 1.0
        logoBackground.layer.backgroundColor = UIColor.white.cgColor
        logoBackground.layer.borderColor = UIColor.lightGray.cgColor
        logoBackground.layer.borderWidth = 0.0
        logoBackground.layer.cornerRadius = logoBackground.bounds.height / 2
        logoBackground.layer.masksToBounds = true
        logoBackground.layer.shadowRadius = 3.5
        logoBackground.layer.shadowColor = UIColor.gray.cgColor
        logoBackground.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackground.layer.shadowOpacity = 1.0
    }
}
