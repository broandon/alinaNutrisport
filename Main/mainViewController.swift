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
    
    let reuseDocument = "sectionsCellStores"
    
    var Sections : [Dictionary<String, Any>] =
        [["Titulo": "Perfil", "ID" : "1", "Imagen" : UIImage(named: "perfil")!],
         ["Titulo": "Dietas", "ID" : "2", "Imagen" : UIImage(named: "manzana")!],
         ["Titulo": "Citas", "ID" : "3", "Imagen" : UIImage(named: "tabla")!],
         ["Titulo": "Archivos", "ID" : "4", "Imagen" : UIImage(named: "documento")!],
         ["Titulo": "Chat", "ID" : "5", "Imagen" : UIImage(named: "chat")!],
         ["Titulo": "Seguimiento Diario", "ID" : "6", "Imagen" : UIImage(named: "reloj")!],
         ["Titulo": "Configuración", "ID" : "7", "Imagen" : UIImage(named: "engrane")!]]
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionview()
        
    }
    
    //MARK: Funcs
    
    func setupCollectionview() {
        
        let documentXib = UINib(nibName: "sectionsCollectionViewCell", bundle: nil)
        
        mainCollection.dataSource = self
        mainCollection.delegate = self
        mainCollection.register(documentXib, forCellWithReuseIdentifier: reuseDocument)
        
    }
    
    func setupView() {
        
        // Change UIView to the name of selected UIView. Is only ptional when there is three viewcontrollers in the swme swift file. Otherwise apply bang.
        
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
    
    //MARK: Collectionview Data
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
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
        
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        


        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "settingsViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        print("Selected")
        
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
