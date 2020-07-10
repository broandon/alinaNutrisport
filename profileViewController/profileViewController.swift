//
//  profileViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 05/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import SDWebImage

class profileViewController: UIViewController {
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    var profileImageSaved: String? = ""
    
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var saveProfileButton: UIButton!
    @IBOutlet weak var profileDataView: UIView!
    @IBOutlet weak var statisticsDataView: UIView!
    @IBOutlet weak var newPhotoDataView: UIView!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getInfo()
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
                    self.profileImageSaved = imageForProfile
                    DispatchQueue.main.async {
                        self.nombreTextField.text = profileData?.data?.info?.nombre
                        self.apellidoTextField.text = profileData?.data?.info?.apellidos
                        self.emailTextField.text = profileData?.data?.info?.telefono
                        self.profileImage.sd_setImage(with: URL(string: imageForProfile ?? "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"), completed: nil)
                    }
                }
            }
        }
        task.resume()
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
            profileImage.sd_setImage(with: URL(string: profileImageSaved ?? ""), completed: nil)
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
    
    @IBAction func saveNewInfo(_ sender: Any) {
        if nombreTextField.text?.isEmpty == true {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "¡Error!", message: "El campo de nombre no puede estár vacio.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            return
        }
        
        if apellidoTextField.text?.isEmpty == true {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "¡Error!", message: "El campo de apellido no puede estár vacio.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            return
        }
        
        if emailTextField.text?.isEmpty == true {
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
        let postString = "funcion=updateUser&id_user="+UserID!+"&first_name="+nombreTextField.text!+"&last_name="+apellidoTextField.text!+"&phone="+emailTextField.text!
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
