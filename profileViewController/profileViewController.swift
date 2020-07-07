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
    @IBOutlet weak var saveProfileButton: UIButton!
    
    @IBOutlet weak var profileDataView: UIView!
    @IBOutlet weak var statisticsDataView: UIView!
    @IBOutlet weak var newPhotoDataView: UIView!
    
    
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
        saveProfileButton.layer.cornerRadius = 13
        statisticsDataView.alpha = 0
        newPhotoDataView.alpha = 0
    }
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            profileImage.image = UIImage(named: "photo-1494790108377-be9c29b29330")
            profileDataView.alpha = 1
            statisticsDataView.alpha = 0
            newPhotoDataView.alpha = 0
        }
        
        if sender.selectedSegmentIndex == 1 {
            profileImage.image = UIImage(named: "graficas1")
            profileDataView.alpha = 0
            statisticsDataView.alpha = 1
            newPhotoDataView.alpha = 0
        }
        
        if sender.selectedSegmentIndex == 2 {
            profileImage.image = UIImage(named: "fotos1")
            profileDataView.alpha = 0
            statisticsDataView.alpha = 0
            newPhotoDataView.alpha = 1
        }
    }
    
    @IBAction func getOut(_ sender: Any) {
        
        self.hero.isEnabled = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        
        self.hero.replaceViewController(with: newViewController)
        
    }
    
    
}
