//
//  loginViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 30/03/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var greenIconsBackgrounds: UIView!
    @IBOutlet weak var greenIconsBacgrounds2: UIView!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotAccount: UIButton!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    //MARK: Funcs
    
    func setupView() {
        
        greenIconsBacgrounds2.layer.cornerRadius = greenIconsBacgrounds2.bounds.height / 2
        greenIconsBackgrounds.layer.cornerRadius = greenIconsBackgrounds.bounds.height / 2
        
        passTF.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(named: "Main Green") ?? UIColor.red, width: 1)
        
        mailTF.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(named: "Main Green") ?? UIColor.red, width: 1)
        mailTF.attributedPlaceholder = NSAttributedString(string: "E-MAIL", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Main Blue")!])
        
        passTF.attributedPlaceholder = NSAttributedString(string: "CONTRASEÑA", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Main Blue")!])
        
        loginButton.layer.cornerRadius = 15
        
    }
    
    //MARK: Buttons
    
    @IBAction func logIn(_ sender: Any) {
        
        
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        
        
        
    }
    
}
