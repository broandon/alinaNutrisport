//
//  documentosViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class documentosViewController: UIViewController {
    
    @IBOutlet weak var behindLogoView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var documentosGenericos: UIView!
    @IBOutlet weak var documentosPersonales: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        behindLogoView?.layer.backgroundColor = UIColor.white.cgColor
        behindLogoView?.layer.borderColor = UIColor.lightGray.cgColor
        behindLogoView?.layer.borderWidth = 0.0
        behindLogoView?.layer.cornerRadius = (behindLogoView?.bounds.height ?? 50) / 2
        behindLogoView?.layer.masksToBounds = true
        behindLogoView?.layer.shadowRadius = 3.5
        behindLogoView?.layer.shadowColor = UIColor.gray.cgColor
        behindLogoView?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        behindLogoView?.layer.shadowOpacity = 1.0
        logoImage?.layer.backgroundColor = UIColor.white.cgColor
        logoImage?.layer.borderColor = UIColor.lightGray.cgColor
        logoImage?.layer.borderWidth = 0.0
        logoImage?.layer.cornerRadius = (logoImage?.bounds.height ?? 50) / 2
        logoImage?.layer.masksToBounds = true
        logoImage?.layer.shadowRadius = 3.5
        logoImage?.layer.shadowColor = UIColor.gray.cgColor
        logoImage?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoImage?.layer.shadowOpacity = 1.0
        documentosPersonales.alpha = 1
        documentosGenericos.alpha = 0
    }
    
    @IBAction func getOut(_ sender: Any) {
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    
    @IBAction func changedSections(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            print("personales")
            documentosPersonales.alpha = 1
            documentosGenericos.alpha = 0
        }
        
        if sender.selectedSegmentIndex == 1 {
            print("generales")
            documentosPersonales.alpha = 0
            documentosGenericos.alpha = 1
        }
    }
}
