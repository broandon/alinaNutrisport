//
//  newInfoData.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 28/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class newInfoData: UIViewController {
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
    //Main Section
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
    @IBOutlet weak var sexImage: UIImageView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }
    
    func setupView() {
        sendInfoButton.layer.cornerRadius = 14
    }
    
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
                let msrmnts = try? JSONDecoder().decode(updatedSepUserMeasurements.self, from: data)
                DispatchQueue.main.async {
                    if msrmnts?.data?.info?.sexo == "1" {
                        self.sexImage.image = UIImage(named: "medias_alina_hombre")
                    }
                    if msrmnts?.data?.info?.sexo == "2" {
                        self.sexImage.image = UIImage(named: "medias_alina_mujer")
                    }
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
    
}
