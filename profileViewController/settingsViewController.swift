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
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
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
    
    func sendToken() {
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let string1 = "funcion=sendToken&id_user="+UserID!
        let string2 = "&token="
        let string3 = "&type_device=1"
        let postString = string1+string2+string3
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, Any> {
                if let state = dictionary["state"] {
                    print(state)
                    let stateNumber = state as! String
                    
                    if stateNumber == "200" {
                        print("Token was deleted correctly")
                    }
                }
            }
        }.resume()
    }

    
    @IBAction func goToSettings(_ sender: Any) {
        
        if let bundleIdentifier = Bundle.main.bundleIdentifier, let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
            
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
    
    @IBAction func getTheFuckOut(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    
    @IBAction func showPrivacy(_ sender: Any) {
        let urlToVisit = "http://alinanutrisport.com.mx/app/privacidad/aviso.pdf"
        
        let vc = webViewViewController(nibName: "webViewViewController", bundle: nil)
        vc.urlToVisit = urlToVisit
        self.present(vc, animated: true)
    }
    
    @IBAction func contact(_ sender: Any) {
        if let url = URL(string: "tel:2225902838") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func sendMailAction(_ sender: Any) {
        if let url = URL(string: "mailto:contacto@alinanutrisport.com") {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func closeSession(_ sender: Any) {
        
        let alert = UIAlertController(title: "Cerrar sesión", message: "¿De verdad quieres cerrar tu sesión? Tendras que escribir tu contraseña nuevamente.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cerrar Sesión", style: .destructive, handler: { action in
            
            self.sendToken()
            
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "LoggedStatus")
                
                self.hero.isEnabled = true
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                newViewController.hero.modalAnimationType = .zoomSlide(direction: .up)
                
                self.hero.replaceViewController(with: newViewController)
            }
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
}
