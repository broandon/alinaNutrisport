//
//  dietsViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class dietsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var dietsCollectionView: UICollectionView!
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    let reuseDocument = "dietsCellStores"
    
    var Diets : [Dictionary<String, Any>] =
           [["Titulo": "Dieta 1", "ID" : "1", "Imagen" : UIImage(named: "manzana")!],
            ["Titulo": "Dieta 2", "ID" : "2", "Imagen" : UIImage(named: "manzana")!],
            ["Titulo": "Dieta 3", "ID" : "3", "Imagen" : UIImage(named: "manzana")!]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupCollectionview()
    }
    
    func setupView() {
        logoBackground.layer.backgroundColor = UIColor.white.cgColor
        logoBackground.layer.borderColor = UIColor.lightGray.cgColor
        logoBackground.layer.borderWidth = 0.0
        logoBackground.layer.cornerRadius = logoBackground.bounds.height / 2
        logoBackground.layer.masksToBounds = true
        logoBackground.layer.shadowRadius = 3.5
        logoBackground.layer.shadowColor = UIColor.gray.cgColor
        logoBackground.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackground.layer.shadowOpacity = 1.0
        
        logoImage.layer.backgroundColor = UIColor.white.cgColor
        logoImage.layer.borderColor = UIColor.lightGray.cgColor
        logoImage.layer.borderWidth = 0.0
        logoImage.layer.cornerRadius = logoImage.bounds.height / 2
        logoImage.layer.masksToBounds = true
        logoImage.layer.shadowRadius = 3.5
        logoImage.layer.shadowColor = UIColor.gray.cgColor
        logoImage.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoImage.layer.shadowOpacity = 1.0
        dietsCollectionView.alpha = 1
    }
    
    func setupCollectionview() {
          let documentXib = UINib(nibName: "dietsCollectionViewCell", bundle: nil)
          dietsCollectionView.dataSource = self
          dietsCollectionView.delegate = self
          dietsCollectionView.register(documentXib, forCellWithReuseIdentifier: reuseDocument)
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 3
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "¡Pronto!", message: "Muy pronto tendrás tus dietas personalizadas en esta sección.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Genial", style: .default, handler: nil))
         
        self.present(alert, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let pickedSections = Diets[indexPath.row]
           let sectionImage = pickedSections["Imagen"] as! UIImage
           let sectionTitle = pickedSections["Titulo"] as! String
           let cell = dietsCollectionView.dequeueReusableCell(withReuseIdentifier: reuseDocument, for: indexPath)
           if let cell = cell as? dietsCollectionViewCell {
               DispatchQueue.main.async {
                cell.image.image = sectionImage
                cell.label.text = sectionTitle
               }
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
