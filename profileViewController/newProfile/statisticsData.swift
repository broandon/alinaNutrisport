//
//  statisticsData.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 28/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import Charts

class statisticsData: UIViewController {
    
    @IBOutlet weak var firstGraphic: LineChartView!
    @IBOutlet weak var secondGraphic: LineChartView!
    @IBOutlet weak var thirdGraphic: LineChartView!
    @IBOutlet weak var fourthGraphic: LineChartView!
    @IBOutlet weak var trackingsTableview: UITableView!
    
    var trackings: [Dictionary<String, Any>] = []
    let reuseDocument = "DocumentCell3"
    var chart1Data : [Double] = []
    var chart2Data : [Double] = []
    var chart3Data : [Double] = []
    var chart4Data : [Double] = []
    var datesInfo : [String] = []
    var number = 0
    
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupCharts()
    }
    
    func setupTableView() {
        let documentXib = UINib(nibName: "trackingsTableViewCell", bundle: nil)
        trackingsTableview!.register(documentXib, forCellReuseIdentifier: reuseDocument)
        trackingsTableview!.delegate = self
        trackingsTableview!.dataSource = self
        trackingsTableview!.separatorStyle = .none
        trackingsTableview!.allowsSelection = true
    }
    
    func getData() {
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
            
            
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, Any> {
                if let data = dictionary["data"] as? Dictionary<String, Any> {
                    if let graficas = data["Graficas"] {
                        print(graficas)
                        for d in data["Graficas"] as! [Dictionary<String, Any>] {
                            print(d)
                            self.trackings.append(d)
                        }
                    }
                }
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
            DispatchQueue.main.async {
                if self.trackings.count > 0 {
                    self.trackingsTableview.reloadData()
                }
            }
        }.resume()
    }
    
    func setupCharts() {
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
        
        fourthGraphic.extraRightOffset = 25
        fourthGraphic.extraLeftOffset = 25
    }
    
}

extension statisticsData: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let document = trackings[indexPath.row]
        let fecha  = document["fecha"] as? String ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath)
        cell.selectionStyle = .none
        if let cell = cell as? trackingsTableViewCell {
            DispatchQueue.main.async {
                cell.date.text = fecha
                let anotherNumber = self.number + 1
                self.number = anotherNumber
                cell.numberOfLabel.text = "\(anotherNumber)"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let document = trackings[indexPath.row]
        let Id  = document["Id"] as? String ?? ""
        let vc = trackingDetailViewController(nibName: "trackingDetailViewController", bundle: nil)
        vc.trackingID = Id
        self.present(vc, animated: true)
    }
}
