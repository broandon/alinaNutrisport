//
//  profileViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 05/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import SDWebImage
import Charts

class profileViewController: UIViewController {
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    var profileImageSaved: String? = ""
    
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var saveProfileButton: UIButton!
    @IBOutlet weak var profileDataView: UIView!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var segmentIndicator: UISegmentedControl!
    
    // Graphics views
    @IBOutlet weak var graphicsScrollView: UIScrollView!
    @IBOutlet weak var firstGraphic: LineChartView!
    @IBOutlet weak var secondGraphic: LineChartView!
    @IBOutlet weak var thirdGraphic: LineChartView!
    @IBOutlet weak var fourthGraphic: LineChartView!
    
    var chart1Data : [Double] = []
    var chart2Data : [Double] = []
    var chart3Data : [Double] = []
    var chart4Data : [Double] = []
    var datesInfo : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getInfo()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupCharts()
    }
    
    func setupCharts() {
        print("called")
        // Chart 1
        var preEntries = [ChartDataEntry]()
        let pre = chart1Data
        
        for i in 0..<pre.count {
            let preDataEntry = ChartDataEntry(x: Double(i), y: pre[i])
            preEntries.append(preDataEntry)
        }
        let nombreMedidas = datesInfo
        firstGraphic.xAxis.valueFormatter = IndexAxisValueFormatter(values: nombreMedidas)
        firstGraphic.xAxis.labelPosition = XAxis.LabelPosition.bottom
        firstGraphic.xAxis.granularity = 1
        firstGraphic.xAxis.labelRotationAngle = 0
        let line1 = LineChartDataSet(entries: preEntries, label: "Peso")
        line1.valueColors = [NSUIColor.black]
        line1.circleColors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line1.lineWidth = 3.0
        line1.colors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line1.drawFilledEnabled = true
        line1.fillColor = UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00)
        let data = LineChartData()
        data.addDataSet(line1)
        firstGraphic.data = data
        firstGraphic.extraRightOffset = 13
        firstGraphic.extraLeftOffset = 13
        
        // CHART 2 -------------------------------
        
        var preEntries2 = [ChartDataEntry]()
        
        let pre2 = chart2Data
        
        for i in 0..<pre2.count {
            let preDataEntry2 = ChartDataEntry(x: Double(i), y: pre2[i])
            preEntries2.append(preDataEntry2)
            
        }
        
        secondGraphic.xAxis.valueFormatter = IndexAxisValueFormatter(values: nombreMedidas)
        secondGraphic.xAxis.labelPosition = XAxis.LabelPosition.bottom
        secondGraphic.xAxis.granularity = 1
        secondGraphic.xAxis.labelRotationAngle = 0
        
        let line2 = LineChartDataSet(entries: preEntries2, label: "Perimetro cintura")
        line2.valueColors = [NSUIColor.black]
        line2.circleColors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line2.lineWidth = 3.0
        line2.colors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line2.drawFilledEnabled = true
        line2.fillColor = UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00)
        
        let data2 = LineChartData()
        
        data2.addDataSet(line2)
        
        secondGraphic.data = data2
        
        secondGraphic.extraRightOffset = 13
        secondGraphic.extraLeftOffset = 13
        
        // CHART 3 -------------------------------
        
        var preEntries3 = [ChartDataEntry]()
        
        let pre3 = chart3Data
        
        for i in 0..<pre3.count {
            let preDataEntry3 = ChartDataEntry(x: Double(i), y: pre3[i])
            preEntries3.append(preDataEntry3)
            
        }
        
        thirdGraphic.xAxis.valueFormatter = IndexAxisValueFormatter(values: nombreMedidas)
        thirdGraphic.xAxis.labelPosition = XAxis.LabelPosition.bottom
        thirdGraphic.xAxis.granularity = 1
        thirdGraphic.xAxis.labelRotationAngle = 0
        
        let line3 = LineChartDataSet(entries: preEntries3, label: "Perimetro Grasa")
        line3.valueColors = [NSUIColor.black]
        line3.circleColors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line3.lineWidth = 3.0
        line3.colors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line3.drawFilledEnabled = true
        line3.fillColor = UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00)
        
        let data3 = LineChartData()
        
        data3.addDataSet(line3)
        
        thirdGraphic.data = data3
        
        thirdGraphic.extraRightOffset = 13
        thirdGraphic.extraLeftOffset = 13
        
        // CHART 4 -------------------------------
        
        var preEntries4 = [ChartDataEntry]()
        
        let pre4 = chart4Data
        
        for i in 0..<pre4.count {
            let preDataEntry4 = ChartDataEntry(x: Double(i), y: pre4[i])
            preEntries4.append(preDataEntry4)
            
        }
        
        fourthGraphic.xAxis.valueFormatter = IndexAxisValueFormatter(values: nombreMedidas)
        fourthGraphic.xAxis.labelPosition = XAxis.LabelPosition.bottom
        fourthGraphic.xAxis.granularity = 1
        fourthGraphic.xAxis.labelRotationAngle = 0
        
        let line4 = LineChartDataSet(entries: preEntries4, label: "Perimetro Musculo")
        line4.valueColors = [NSUIColor.black]
        line4.circleColors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line4.lineWidth = 3.0
        line4.colors = [NSUIColor(cgColor: UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00).cgColor)]
        line4.drawFilledEnabled = true
        line4.fillColor = UIColor(red: 0.34, green: 0.47, blue: 0.38, alpha: 1.00)
        
        let data4 = LineChartData()
        
        data4.addDataSet(line4)
        
        fourthGraphic.data = data4
        
        fourthGraphic.extraRightOffset = 13
        fourthGraphic.extraLeftOffset = 13
    }
    
    
    func getInfo() {
        print("called GetInfo")
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
                        self.nombreTextField.text = profileData?.data?.info?.nombre
                        self.apellidoTextField.text = profileData?.data?.info?.apellidos
                        self.emailTextField.text = profileData?.data?.info?.telefono
                        
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
    
    func getData() {
        print("called Get Data")
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "funcion=getGraphics&id_user="+UserID!
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("error: No data to decode")
                return
            }
            guard let userInfo = try? JSONDecoder().decode(graphGraphicsDaa.self, from: data) else {
                print("Error: Couldn't decode data into info")
                return
            }
            let modelData = userInfo.data!.graficas
            let dictionaryFromData = modelData!.asDictionaryFromArray()
            
            for key in dictionaryFromData {
                for (key, value) in key {
                    
                    if key == "fecha" {
                        let fechaValue = value as! String
                        self.datesInfo.append(fechaValue)
                    }
                    
                    if key == "peso" {
                        let pesoValue = value as! String
                        let pesoDouble = Double(pesoValue)
                        self.chart1Data.append(pesoDouble ?? 0.0)
                    }
                    
                    if key == "cintura_perimetro" {
                        let cpValue = value as! String
                        let cpDouble = Double(cpValue)
                        self.chart2Data.append(cpDouble ?? 0.0)
                    }
                    
                    if key == "p_grasa" {
                        let pGrasaValue = value as! String
                        let pGrasaDouble = Double(pGrasaValue)
                        self.chart3Data.append(pGrasaDouble ?? 0.0)
                    }
                    
                    if key == "p_musculo" {
                        let pMusculoValue = value as! String
                        let pMusculoDouble = Double(pMusculoValue)
                        self.chart4Data.append(pMusculoDouble ?? 0.0)
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
        graphicsScrollView.alpha = 0
        if UserDefaults.standard.bool(forKey: "comingFromProfile") == true {
            segmentIndicator.selectedSegmentIndex = 1
            profileImage.image = UIImage(named: "graficas1")
            profileDataView.alpha = 0
            graphicsScrollView.alpha = 1
            UserDefaults.standard.set(false, forKey: "comingFromProfile")
        }
    }
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            profileImage.sd_setImage(with: URL(string: profileImageSaved ?? ""), completed: nil)
            profileDataView.alpha = 1
            graphicsScrollView.alpha = 0
        }
        
        if sender.selectedSegmentIndex == 1 {
            profileImage.image = UIImage(named: "graficas1")
            profileDataView.alpha = 0
            graphicsScrollView.alpha = 1
        }
        
        if sender.selectedSegmentIndex == 2 {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "profleOtherViewController") as! profleOtherViewController
            newViewController.hero.modalAnimationType = .none
            self.hero.replaceViewController(with: newViewController)
            profileImage.image = UIImage(named: "fotos1")
            profileDataView.alpha = 0
            graphicsScrollView.alpha = 0
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

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Encodable {
    var dictionaryFromObject: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Array where Element: Encodable {
    func asDictionaryFromArray() -> [[String: Any]] {
        var dict = [[String: Any]]()
        _ = self.map {
            if let objectDict = $0.dictionaryFromObject {
                dict.append(objectDict)
            }
        }
        return dict
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var removingAllWhitespaces: Self {
        filter { !$0.isWhitespace }
    }
    mutating func removeAllWhitespaces() {
        removeAll(where: \.isWhitespace)
    }
}
