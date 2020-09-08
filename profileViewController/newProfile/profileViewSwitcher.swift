//
//  profileViewSwitcher.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 28/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class profileViewSwitcher: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var statisticsProfile: UIView!
    @IBOutlet weak var newInfoview: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var segmentedIndexControl: UISegmentedControl!
    
    
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    var profileImageSaved: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getInfo()
        if UserDefaults.standard.bool(forKey: "comingFromProfile") == true {
            segmentedIndexControl.selectedSegmentIndex = 1
            profileImage.image = UIImage(named: "graficas1")
            UserDefaults.standard.set(false, forKey: "comingFromProfile")
            self.profileView.alpha = 0
            self.statisticsProfile.alpha = 2
            self.newInfoview.alpha = 0
            self.profileImage.image = UIImage(named: "graficas1")
            self.segmentedIndexControl.isHidden = true
        }
    }
    
    func setupView() {
        profileView.alpha = 1
        statisticsProfile.alpha = 0
        newInfoview.alpha = 0
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
        profileView.slideInFromBottom()
        statisticsProfile.slideInFromBottom()
        newInfoview.slideInFromBottom()
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
                    self.profileImageSaved = imageReal
                    DispatchQueue.main.async {
                        if UserDefaults.standard.bool(forKey: "loadImage") == true {
                        self.profileImage.sd_setImage(with: URL(string: imageReal!), completed: nil)
                        UserDefaults.standard.set(false, forKey: "loadImage")
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func viewSwitcher(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.4, animations: {
                self.profileImage.sd_setImage(with: URL(string: self.profileImageSaved ?? ""), completed: nil)
                self.profileView.alpha = 1
                self.statisticsProfile.alpha = 0
                self.newInfoview.alpha = 0
            })
        }
        
        if sender.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.4, animations: {
                self.profileView.alpha = 0
                self.statisticsProfile.alpha = 2
                self.newInfoview.alpha = 0
                self.profileImage.image = UIImage(named: "graficas1")
            })
        }
        
        if sender.selectedSegmentIndex == 2 {
            UIView.animate(withDuration: 0.4, animations: {
                self.profileView.alpha = 0
                self.statisticsProfile.alpha = 0
                self.newInfoview.alpha = 1
                self.profileImage.image = UIImage(named: "fotos1")
            })
        }
        
    }
    
    @IBAction func getOut(_ sender: Any) {
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)    }
}
