//
//  profileData.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 28/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class profileData: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var saveProfileButton: UIButton!
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getInfo()
    }
    
    func setupView() {
        saveProfileButton.layer.cornerRadius = 14
    }
    
    func getInfo() {
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getUserInfo&id_user="+UserID!
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let profileData = try? JSONDecoder().decode(firstProfileInfo.self, from: data)
                
                if profileData?.state == "200" {
                    DispatchQueue.main.async {
                        self.nameTF.text = profileData?.data?.info?.nombre
                        self.lastNameTF.text = profileData?.data?.info?.apellidos
                        self.phoneTF.text = profileData?.data?.info?.telefono
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func saveInfo(_ sender: Any) {
        
        if nameTF.text?.isEmpty == true {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "¡Error!", message: "El campo de nombre no puede estár vacio.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            return
        }
        
        if lastNameTF.text?.isEmpty == true {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "¡Error!", message: "El campo de apellido no puede estár vacio.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            return
        }
        
        if phoneTF.text?.isEmpty == true {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "¡Error!", message: "El campo de telefono no puede estár vacio.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            return
        }
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=updateUser&id_user="+UserID!+"&first_name="+nameTF.text!+"&last_name="+lastNameTF.text!+"&phone="+phoneTF.text!
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let profileData = try? JSONDecoder().decode(firstUpdatedProfile.self, from: data)
                
                if profileData?.state == "200" {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "¡Éxito!", message: "Tus datos se han guardado correctamente.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "¡Error!", message: "No se pudieron actualizar tus datos. Espera unos minutos e intentalo de nuevo.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
            
        }
        task.resume()
    }
    
}
