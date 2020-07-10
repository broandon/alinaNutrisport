//
//  loginViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 30/03/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import Hero

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
    
    @IBAction func forgotAccount(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "recoverViewController")
        self.present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        
        if mailTF.text?.isEmpty == true {
            let alert = UIAlertController(title: "El campo de correo no puede estar vacío", message: "Ingresa tu correo electrónico.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        if passTF.text?.isEmpty == true {
            let alert = UIAlertController(title: "El campo de contraseña no puede estar vacío", message: "Ingresa tu contraseña.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=login&email="+mailTF.text!+"&password="+passTF.text!
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let recoverResponse = try? JSONDecoder().decode(Login.self, from: data)
                
                if recoverResponse?.state == "200" {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(true, forKey: "LoggedStatus")
                        UserDefaults.standard.set("\(recoverResponse?.data.idUser ?? "")", forKey: "IDUser")
                        UserDefaults.standard.set("\(recoverResponse?.data.firstName ?? "")", forKey: "FirstName")
                        UserDefaults.standard.set("\(recoverResponse?.data.lastName ?? "")", forKey: "LastName")
                        UserDefaults.standard.set("\(recoverResponse?.data.mail ?? "")", forKey: "Mail")
                        
                        print("THIS IS THE INFO****************************")
                        print(UserDefaults.standard.string(forKey: "IDUser"))
                        print(UserDefaults.standard.string(forKey: "FirstName"))
                        print(UserDefaults.standard.string(forKey: "LastName"))
                        print(UserDefaults.standard.string(forKey: "Mail"))
                        print(UserDefaults.standard.bool(forKey: "LoggedStatus"))
                        print("********************************************")
                        
                        self.hero.isEnabled = true
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
                        newViewController.hero.modalAnimationType = .zoomSlide(direction: .down)
                        self.hero.replaceViewController(with: newViewController)
                    }
                }
                
                if recoverResponse?.state == nil {
                    DispatchQueue.main.async {
                        let alert2 = UIAlertController(title: "Ha habido un error al recibir tu información.", message: "Por favor intentalo de nuevo mas tarde.", preferredStyle: .alert)
                        alert2.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
                        self.present(alert2, animated: true)
                        return
                    }
                }
                
                if recoverResponse?.state == "101" {
                    
                    let alert = UIAlertController(title: "Error", message: "Tu contraseña es incorrecta o ese correo no está registrado", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    
                }
            }
            
        }
        
        task.resume()
        
    }
    
    
}
