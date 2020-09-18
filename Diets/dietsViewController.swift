//
//  dietsViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class dietsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, dietButtonAction {
    
    @IBOutlet weak var dietsCollectionView: UICollectionView!
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    
    let reuseDocument = "dietsCellStores"
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    var Diets : [Dictionary<String, Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        setupView()
        setupCollectionview()
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
        logoImage.layer.backgroundColor = UIColor.white.cgColor
        logoImage.layer.borderColor = UIColor.lightGray.cgColor
        logoImage.layer.borderWidth = 0.0
        logoImage.layer.cornerRadius = logoImage.bounds.height / 2
        logoImage.layer.masksToBounds = true
        dietsCollectionView.alpha = 1
    }
    
    func setupCollectionview() {
        let documentXib = UINib(nibName: "dietsCollectionViewCell", bundle: nil)
        dietsCollectionView.dataSource = self
        dietsCollectionView.delegate = self
        dietsCollectionView.register(documentXib, forCellWithReuseIdentifier: reuseDocument)
    }
    
    func downloadJson() {
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getDiets&id_user=" + UserID!
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, Any> {
                for d in dictionary["data"] as! [Dictionary<String, Any>] {
                    self.Diets.append(d)
                }
            }
            DispatchQueue.main.async {
                
                if self.Diets.count > 0 {
                    self.dietsCollectionView.reloadData()
                }
                
            }
        }.resume()
    }
    
    func showTodaysMenu(idNumber: String) {
        let myViewController = todayDietPopUpViewController(nibName: "todayDietPopUpViewController", bundle: nil)
        myViewController.dietID = idNumber
        myViewController.modalPresentationStyle = .overCurrentContext
        
        if #available(iOS 13.0, *) {
            myViewController.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        self.present(myViewController, animated: false, completion: nil)
    }
    
    func showAllMenu(URL: String) {
        let vc = webViewViewController(nibName: "webViewViewController", bundle: nil)
        vc.urlToVisit = URL
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Diets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pickedSections = Diets[indexPath.row]
        let sectionImage = UIImage(named: "manzana")
        let sectionTitle = pickedSections["fecha"]
        let dietID = pickedSections["Id"] as! String
        let URL = pickedSections["url"] as! String
        let cell = dietsCollectionView.dequeueReusableCell(withReuseIdentifier: reuseDocument, for: indexPath)
        
        if let cell = cell as? dietsCollectionViewCell {
            DispatchQueue.main.async {
                cell.image.image = sectionImage
                cell.label.text = sectionTitle as? String
            }
            cell.delegate = self
            let dietIDInt = Int(dietID)
            cell.todaysMenuButton.tag = dietIDInt!
            cell.cellURL = URL
        }
        return cell
    }
    
    @IBAction func getOut(_ sender: Any) {
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    
    @IBAction func sectionChange(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            dietsCollectionView.alpha = 1
        }
        
        if sender.selectedSegmentIndex == 1 {
            dietsCollectionView.alpha = 0
        }
    }
}

extension dietsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 155, height: 155)
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
