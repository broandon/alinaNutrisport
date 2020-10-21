//
//  trackingDetailViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 13/10/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class trackingDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    // First Part
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statureLabel: UILabel!
    @IBOutlet weak var physicalLabel: UILabel!
    @IBOutlet weak var complexionLabel: UILabel!
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var fatPercentageLabel: UILabel!
    @IBOutlet weak var musclePercentageLabel: UILabel!
    @IBOutlet weak var waterPercentageLabel: UILabel!
    @IBOutlet weak var boneMassLabel: UILabel!
    @IBOutlet weak var visceralFatLabel: UILabel!
    @IBOutlet weak var basalMetabolismLabel: UILabel!
    @IBOutlet weak var physicalEvaluationLabel: UILabel!
    @IBOutlet weak var metabolicAgeLabel: UILabel!
    
    // Second Part
    @IBOutlet weak var cinturaCM: UILabel!
    @IBOutlet weak var hipCM: UILabel!
    @IBOutlet weak var relaxedArmCM: UILabel!
    @IBOutlet weak var wristCM: UILabel!
    @IBOutlet weak var pantorrillaCM: UILabel!
    @IBOutlet weak var ankleCM: UILabel!
    @IBOutlet weak var antebrazoCM: UILabel!
    @IBOutlet weak var chestCM: UILabel!
    @IBOutlet weak var comentariesCM: UILabel!
    
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    var trackingID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }
    
    func getInfo() {
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getTracking&id_user="+UserID!+"&id_track="+trackingID
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let msrmnts = try? JSONDecoder().decode(sepNewTrackingInfo.self, from: data)
                DispatchQueue.main.async {
                    self.dateLabel.text = msrmnts?.data?.info?.fecha
                    self.statureLabel.text = msrmnts?.data?.info?.altura
                    self.physicalLabel.text = msrmnts?.data?.info?.actividadFisica
                    self.complexionLabel.text = msrmnts?.data?.info?.complexion
                    self.currentWeightLabel.text = msrmnts?.data?.info?.peso
                    self.fatPercentageLabel.text = msrmnts?.data?.info?.pGrasa
                    self.musclePercentageLabel.text =
                        msrmnts?.data?.info?.pMusculo
                    self.waterPercentageLabel.text = msrmnts?.data?.info?.pAgua
                    self.boneMassLabel.text = msrmnts?.data?.info?.masaOsea
                    self.visceralFatLabel.text = msrmnts?.data?.info?.grasaVisceral
                    self.basalMetabolismLabel.text = msrmnts?.data?.info?.calorias
                    self.physicalEvaluationLabel.text = msrmnts?.data?.info?.evFisica
                    self.metabolicAgeLabel.text = msrmnts?.data?.info?.edadMetabolica
                    
                    self.cinturaCM.text = msrmnts?.data?.info?.cinturaPerimetro
                    self.hipCM.text = msrmnts?.data?.info?.caderaPerimetro
                    self.relaxedArmCM.text = msrmnts?.data?.info?.brazoRelajadoPerimetro
                    self.wristCM.text = msrmnts?.data?.info?.muniecaPerimetro
                    self.pantorrillaCM.text = msrmnts?.data?.info?.pantorrillaPerimetro
                    self.ankleCM.text = msrmnts?.data?.info?.tobilloPerimetro
                    self.antebrazoCM.text = msrmnts?.data?.info?.antebrazoPerimetro
                    self.chestCM.text = msrmnts?.data?.info?.pechoPerimetro
                    self.comentariesCM.text = msrmnts?.data?.info?.comment
                }
            }
        }
        task.resume()
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
