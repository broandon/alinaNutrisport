//
//  profleOtherViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 14/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class profleOtherViewController: UIViewController {
    
    //MARK: Outlets
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
    //MainView
    @IBOutlet weak var segmentIndicator: UISegmentedControl!
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var logo: UIView!
    
    //First Section
    @IBOutlet weak var pesoTF: UITextField!
    @IBOutlet weak var alturaTF: UITextField!
    @IBOutlet weak var pGrasaTF: UITextField!
    @IBOutlet weak var musculoKGTF: UITextField!
    @IBOutlet weak var pAguaTF: UITextField!
    
    //Second Section
    @IBOutlet weak var masaOseaGKTF: UITextField!
    @IBOutlet weak var pesoTresAñosTF: UITextField!
    @IBOutlet weak var grasaVisceralTF: UITextField!
    @IBOutlet weak var metabolismoBasal: UITextField!
    @IBOutlet weak var evaluacionFisica: UITextField!
    @IBOutlet weak var edadMetabolica: UITextField!
    @IBOutlet weak var pesoEsperado: UITextField!
    
    //Third Section
    @IBOutlet weak var tricepsTF: UITextField!
    @IBOutlet weak var bicepsTF: UITextField!
    @IBOutlet weak var abdominalTF: UITextField!
    @IBOutlet weak var pantorrilaTF: UITextField!
    @IBOutlet weak var subaescapularTF: UITextField!
    @IBOutlet weak var suprailiacoTF: UITextField!
    @IBOutlet weak var musloTF: UITextField!
    
    //Fourth Section
    @IBOutlet weak var cinturaTF: UITextField!
    @IBOutlet weak var abdomenTF: UITextField!
    @IBOutlet weak var caderaTF: UITextField!
    @IBOutlet weak var brazoRelajadoTF: UITextField!
    @IBOutlet weak var muñecaTF: UITextField!
    @IBOutlet weak var tobilloTF: UITextField!
    @IBOutlet weak var pantorrilla2TF: UITextField!
    @IBOutlet weak var muslo2: UITextField!
    @IBOutlet weak var antebrazo2TF: UITextField!
    @IBOutlet weak var pecho: UITextField!
    @IBOutlet weak var comentariosTF: UITextField!
    
    //Button
    @IBOutlet weak var sendInfoButton: UIButton!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getInfo()
    }
    
    //MARK: Funcs
    
    func getInfo() {
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getLastTracking&id_user="+UserID!
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let msrmnts = try? JSONDecoder().decode(profileMeasurementsMeasurementsData.self, from: data)
                DispatchQueue.main.async {
                    self.pesoTF.text = msrmnts?.data?.info?.peso
                    self.alturaTF.text = msrmnts?.data?.info?.altura
                    self.pGrasaTF.text = msrmnts?.data?.info?.pGrasa
                    self.musculoKGTF.text = msrmnts?.data?.info?.pMusculo
                    self.pAguaTF.text = msrmnts?.data?.info?.pAgua
                    self.masaOseaGKTF.text = msrmnts?.data?.info?.pAgua
                    self.pesoTresAñosTF.text = msrmnts?.data?.info?.mejorPeso
                    self.grasaVisceralTF.text = msrmnts?.data?.info?.grasaVisceral
                    self.metabolismoBasal.text = msrmnts?.data?.info?.metabolismoBasal
                    self.evaluacionFisica.text = msrmnts?.data?.info?.evFisica
                    self.edadMetabolica.text = msrmnts?.data?.info?.edadMetabolica
                    self.pesoEsperado.text = msrmnts?.data?.info?.pesoEsperado
                    self.tricepsTF.text = msrmnts?.data?.info?.tricepsGrasa
                    self.bicepsTF.text = msrmnts?.data?.info?.bicepsGrasa
                    self.abdominalTF.text = msrmnts?.data?.info?.abdominalGrasa
                    self.pantorrilaTF.text = msrmnts?.data?.info?.pantorrillaGrasa
                    self.subaescapularTF.text = msrmnts?.data?.info?.subescopularGrasa
                    self.suprailiacoTF.text = msrmnts?.data?.info?.suprailiacoGrasa
                    self.musloTF.text = msrmnts?.data?.info?.musloGrasa
                    self.cinturaTF.text = msrmnts?.data?.info?.cinturaPerimetro
                    self.abdomenTF.text = msrmnts?.data?.info?.abdomenPerimetro
                    self.caderaTF.text = msrmnts?.data?.info?.cinturaPerimetro
                    self.brazoRelajadoTF.text = msrmnts?.data?.info?.brazoRelajadoPerimetro
                    self.muñecaTF.text = msrmnts?.data?.info?.muniecaPerimetro
                    self.tobilloTF.text = msrmnts?.data?.info?.tobilloPerimetro
                    self.muslo2.text = msrmnts?.data?.info?.musloPerimetro
                    self.pantorrilla2TF.text = msrmnts?.data?.info?.pantorrillaPerimetro
                    self.antebrazo2TF.text = msrmnts?.data?.info?.antebrazoPerimetro
                    self.pecho.text = msrmnts?.data?.info?.pechoPerimetro
                    self.comentariosTF.text = msrmnts?.data?.info?.comment
                }
            }
        }
        task.resume()
    }
    
    func setupView() {
        segmentIndicator.selectedSegmentIndex = 2
        logo.layer.backgroundColor = UIColor.white.cgColor
        logo.layer.borderColor = UIColor.lightGray.cgColor
        logo.layer.borderWidth = 0.0
        logo.layer.cornerRadius = logo.bounds.height / 2
        logo.layer.masksToBounds = true
        logo.layer.shadowRadius = 3.5
        logo.layer.shadowColor = UIColor.gray.cgColor
        logo.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logo.layer.shadowOpacity = 1.0
        logoBackground.layer.backgroundColor = UIColor.white.cgColor
        logoBackground.layer.borderColor = UIColor.lightGray.cgColor
        logoBackground.layer.borderWidth = 0.0
        logoBackground.layer.cornerRadius = logoBackground.bounds.height / 2
        logoBackground.layer.masksToBounds = true
        logoBackground.layer.shadowRadius = 3.5
        logoBackground.layer.shadowColor = UIColor.gray.cgColor
        logoBackground.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackground.layer.shadowOpacity = 1.0
        sendInfoButton.layer.cornerRadius = 13
    }
    
    //MARK: Actions
    
    @IBAction func getOut(_ sender: Any) {
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    
    @IBAction func changingSegments(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(true, forKey: "loadImage")
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewController") as! profileViewController
            newViewController.hero.modalAnimationType = .none
            self.hero.replaceViewController(with: newViewController)
        }
        
        if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.set(true, forKey: "comingFromProfile")
            UserDefaults.standard.set(false, forKey: "loadImage")
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewController") as! profileViewController
            newViewController.hero.modalAnimationType = .none
            self.hero.replaceViewController(with: newViewController)
        }
    }
}
