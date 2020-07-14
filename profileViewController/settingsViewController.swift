//
//  settingsViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var imagenBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        logoBackground.layer.backgroundColor = UIColor.white.cgColor
        logoBackground.layer.borderColor = UIColor.lightGray.cgColor
        logoBackground.layer.borderWidth = 0.0
        logoBackground.layer.cornerRadius = logoBackground.bounds.height / 2
        logoBackground.layer.masksToBounds = false
        logoBackground.layer.shadowRadius = 3.5
        logoBackground.layer.shadowColor = UIColor.gray.cgColor
        logoBackground.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackground.layer.shadowOpacity = 1.0
    }
    
    @IBAction func getTheFuckOut(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    @IBAction func closeSession(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "LoggedStatus")
        
        self.hero.isEnabled = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        newViewController.hero.modalAnimationType = .zoomSlide(direction: .up)
        
        self.hero.replaceViewController(with: newViewController)
        
    }
    
}
