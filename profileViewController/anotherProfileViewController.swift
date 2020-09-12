//
//  anotherProfileViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 11/09/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class anotherProfileViewController: UIViewController {
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    @IBOutlet weak var upperCircle: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var dataScrollView: UIScrollView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var saveProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.alpha = 0
        setupView()
        getInfo()
        getData()
    }
    
    func setupView() {
        saveProfileButton.layer.cornerRadius = 15
        dataScrollView.slideInFromBottom()
        upperCircle.slideInFromTop()
        logoBackground?.layer.backgroundColor = UIColor.white.cgColor
        logoBackground?.layer.borderColor = UIColor.lightGray.cgColor
        logoBackground?.layer.borderWidth = 0.0
        logoBackground?.layer.cornerRadius = 84.5
        logoBackground?.layer.masksToBounds = false
        logoBackground?.layer.shadowRadius = 3.5
        logoBackground?.layer.shadowColor = UIColor.gray.cgColor
        logoBackground?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackground?.layer.shadowOpacity = 1.0
        profileImage?.layer.backgroundColor = UIColor.white.cgColor
        profileImage?.layer.borderColor = UIColor.lightGray.cgColor
        profileImage?.layer.borderWidth = 0.0
        profileImage?.layer.cornerRadius = 84.5
        profileImage?.layer.masksToBounds = true
        UIView.animate(withDuration: 2.0, animations: {
            self.profileImage.alpha = 1
        })
    }
    
    func getData() {
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
                    let imageForProfile = profileData?.data?.info?.imagen
                    let imageReal = imageForProfile?.removingAllWhitespaces
                    DispatchQueue.main.async {
                        self.profileImage.sd_setImage(with: URL(string: imageReal ?? ""), completed: nil)
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func closeThisView(_ sender: Any) {
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    
    @IBAction func saveNewInfo(_ sender: Any) {
        
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
