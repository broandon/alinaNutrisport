//
//  trackingViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 12/09/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class trackingViewController: UIViewController {
    
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        logoBackground?.layer.backgroundColor = UIColor.white.cgColor
        logoBackground?.layer.borderColor = UIColor.lightGray.cgColor
        logoBackground?.layer.borderWidth = 0.5
        logoBackground?.layer.cornerRadius = (logoBackground?.bounds.height ?? 50) / 2
        logoBackground?.layer.masksToBounds = false
        logoBackground?.layer.shadowRadius = 4.5
        logoBackground?.layer.shadowColor = UIColor.gray.cgColor
        logoBackground?.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        logoBackground?.layer.shadowOpacity = 1.0
        profileImage?.layer.backgroundColor = UIColor.white.cgColor
        profileImage?.layer.borderColor = UIColor.lightGray.cgColor
        profileImage?.layer.borderWidth = 0.5
        profileImage?.layer.cornerRadius = (profileImage?.bounds.height ?? 50) / 2
        profileImage?.layer.masksToBounds = true
        profileImage?.layer.shadowRadius = 4.5
        profileImage?.layer.shadowColor = UIColor.gray.cgColor
        profileImage?.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        profileImage?.layer.shadowOpacity = 1.0
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            firstView?.alpha = 1
            secondView?.alpha = 0
        }
        
        if sender.selectedSegmentIndex == 1 {
            firstView?.alpha = 0
            secondView?.alpha = 1
        }
    }
}
