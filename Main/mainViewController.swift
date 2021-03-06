//
//  mainViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class mainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var mainCollection: UICollectionView!
    @IBOutlet weak var upperCircle: UIImageView!
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    let pushManager = PushNotificationManager(userID: "currently_logged_in_user_id")
    
    let reuseDocument = "sectionsCellStores"
    var Sections : [Dictionary<String, Any>] =
        [["Titulo": "Perfil", "ID" : "1", "Imagen" : UIImage(named: "perfil")!], ["Titulo": "Consultas", "ID" : "8", "Imagen" : UIImage(named: "seguimientos")!], ["Titulo": "Dietas", "ID" : "2", "Imagen" : UIImage(named: "manzana")!], ["Titulo": "Seguimiento Diario", "ID" : "6", "Imagen" : UIImage(named: "reloj")!], ["Titulo": "Chat", "ID" : "5", "Imagen" : UIImage(named: "chat")!], ["Titulo": "Archivos", "ID" : "4", "Imagen" : UIImage(named: "documento")!], ["Titulo": "Citas", "ID" : "3", "Imagen" : UIImage(named: "tabla")!], ["Titulo": "Configuración", "ID" : "7", "Imagen" : UIImage(named: "engrane")!]]
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginStatusCheck()
        setupView()
        setupCollectionview()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
                
                let alert = UIAlertController(title: "Nueva versión.", message: "Si esta es una nueva versión de la app cierra la sesión para evitar algunos errores.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cerrar Sesión", style: .destructive, handler: { action in
                    
                    
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
    
    //MARK: Funcs
    
    func sendToken() {
        let currentToken = pushManager.getToken()
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let string1 = "funcion=sendToken&id_user="+UserID!
        let string2 = "&token="+currentToken
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
                    let stateNumber = state as! String
                    
                    if stateNumber == "200" {
                        print("Token was accepted correctly")
                    }
                }
            }
        }.resume()
    }
    
    func loginStatusCheck() {
        if UserDefaults.standard.bool(forKey: "LoggedStatus") == false {
            resetRoot()
        } else {
            sendToken()
        }
    }
    
    func resetRoot() {
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as? loginViewController else {
            return
        }
        UIApplication.shared.windows.first?.rootViewController = rootVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func setupCollectionview() {
        let documentXib = UINib(nibName: "sectionsCollectionViewCell", bundle: nil)
        mainCollection.dataSource = self
        mainCollection.delegate = self
        mainCollection.register(documentXib, forCellWithReuseIdentifier: reuseDocument)
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
        if UserDefaults.standard.bool(forKey: "firstTimer") == true {
            upperCircle.slideInFromTop()
            UserDefaults.standard.set(false, forKey: "firstTimer")
        }
    }
    
    //MARK: Collectionview Data
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pickedSections = Sections[indexPath.row]
        let sectionID = pickedSections["ID"] as! String
        
        if sectionID == "1" {
            self.hero.isEnabled = true
            let myViewController = anotherProfileViewController(nibName: "anotherProfileViewController", bundle: nil)
            myViewController.hero.modalAnimationType = .zoomSlide(direction: .left)
            self.hero.replaceViewController(with: myViewController)
            return
            //            UserDefaults.standard.set(true, forKey: "loadImage")
            //            self.hero.isEnabled = true
            //            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //            let newViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewSwitcher") as! profileViewSwitcher
            //            newViewController.hero.modalAnimationType = .pageIn(direction: .left)
            //            self.hero.replaceViewController(with: newViewController)
        }
        
        if sectionID == "2" {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "dietsViewController") as! dietsViewController
            newViewController.hero.modalAnimationType = .pageIn(direction: .left)
            self.hero.replaceViewController(with: newViewController)
        }
        
        if sectionID == "7" {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "settingsViewController") as! settingsViewController
            newViewController.hero.modalAnimationType = .pageIn(direction: .left)
            self.hero.replaceViewController(with: newViewController)
        }
        
        if sectionID == "3" {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "datesViewController") as! datesViewController
            newViewController.hero.modalAnimationType = .pageIn(direction: .left)
            self.hero.replaceViewController(with: newViewController)
        }
        
        if sectionID == "4" {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "documentosViewController") as! documentosViewController
            newViewController.hero.modalAnimationType = .pageIn(direction: .left)
            self.hero.replaceViewController(with: newViewController)
        }
        
        if sectionID == "5" {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "chatViewController") as! chatViewController
            newViewController.hero.modalAnimationType = .pageIn(direction: .left)
            self.hero.replaceViewController(with: newViewController)
        }
        
        if sectionID == "8" {
            UserDefaults.standard.set(false, forKey: "loadImage")
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewSwitcher") as! profileViewSwitcher
            UserDefaults.standard.set(true, forKey: "comingFromProfile")
            newViewController.hero.modalAnimationType = .pageIn(direction: .left)
            self.hero.replaceViewController(with: newViewController)
        }
        
        if sectionID == "6" {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "tracking", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "trackingViewController") as! trackingViewController
            newViewController.hero.modalAnimationType = .zoomSlide(direction: .left)
            self.hero.replaceViewController(with: newViewController)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pickedSections = Sections[indexPath.row]
        let sectionImage = pickedSections["Imagen"] as! UIImage
        let sectionTitle = pickedSections["Titulo"] as! String
        let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: reuseDocument, for: indexPath)
        if let cell = cell as? sectionsCollectionViewCell {
            DispatchQueue.main.async {
                cell.sectionImage.image = sectionImage
                cell.sectionLabel.text = sectionTitle
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth : CGFloat = 300
        let numberOfCells = floor(self.view.frame.size.width / cellWidth)
        let edgeInsets = (self.view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1.5)
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 10, right: edgeInsets)
    }
}

extension mainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 110, height: 110)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50.0
    }
    
}
