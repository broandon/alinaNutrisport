//
//  dailyTrackingViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 12/09/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class dailyTrackingViewController: UIViewController, addAndSubstractFood {
    
    @IBOutlet weak var upperDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var previousDateButton: UIButton!
    @IBOutlet weak var nextDateButton: UIButton!
    @IBOutlet weak var mainViewBackground: UIView!
    
    let reuseDocument = "DocumentCell3"
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    var trackings : [Dictionary<String, Any>] = []
    var dateforWebservice : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        getDate()
    }
    
    func setupTableView () {
        let documentXib = UINib(nibName: "dailyInfoTableViewCell", bundle: nil)
        tableView!.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = false
    }
    
    func setupView() {
        mainViewBackground.layer.cornerRadius = 15
        mainViewBackground.layer.borderColor = UIColor.lightGray.cgColor
        mainViewBackground.layer.borderWidth = 0.5
    }
    
    func getDate() {
        let date1 = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd-MM-yyyy"
        let result1 = formatter1.string(from: date1)
        self.upperDate.text = result1
        
        let date2 = Date()
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        let result2 = formatter2.string(from: date2)
        getDietInformation(Date: result2)
    }
    
    func updateDailyMenuDiet(menuID: String, quantity: String) {
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let string1 = "funcion=updateDailyMenu&id_menu="+menuID+"&quantity="+quantity
        let string2 = "&id_user="+UserID!
        let postString = string1 + string2
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, Any> {
                print(dictionary)
            }
        }.resume()
    }
    
    func getDietInformation(Date: String) {
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getDailyMenuForDate&id_user="+UserID!+"&date="+Date
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, Any> {
                if let data = dictionary["data"] {
                    if let seguimientos = data as? Dictionary<String, Any> {
                        if let menuDia = seguimientos["seguimientoDia"] as? [Dictionary<String, Any>]{
                            self.trackings = menuDia
                        }
                    }
                }}
            DispatchQueue.main.async {
                
                if self.trackings.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
    
    @IBAction func goToPreviousDate(_ sender: Any) {
        let currentDate = self.upperDate.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from:currentDate!)
        let dateBefore = date?.dayBefore
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: dateBefore!)
        self.upperDate.text = result

        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        let result2 = formatter2.string(from: dateBefore!)
        getDietInformation(Date: result2)
    }
    
    @IBAction func goToNextDate(_ sender: Any) {
        let currentDate = self.upperDate.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from:currentDate!)
        let dateBefore = date?.dayAfter
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: dateBefore!)
        self.upperDate.text = result
        getDietInformation(Date: result)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        let result2 = formatter2.string(from: dateBefore!)
        getDietInformation(Date: result2)
    }
    
}

extension dailyTrackingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath) as! dailyInfoTableViewCell
        cell.delegate = self
        let document = trackings[indexPath.row]
        let name  = document["nombre"] as? String ?? ""
        let eq = document["equivalencia"] as? String ?? ""
        let ca = document["cantidad"] as? String ?? ""
        let id = document["Id"] as? String ?? ""
        cell.firstQuantity = eq
        cell.menuID = id
        DispatchQueue.main.async {
            cell.foodName.text = name
            cell.EqLabel.text = eq
            cell.caLabel.text = ca
            if Double(eq)! > Double(ca)! {
                cell.faceHumor.image = UIImage(named: "okface")
            }
            if Double(eq) == Double(ca) {
                cell.faceHumor.image = UIImage(named: "hungyface")
            }
            if Double(eq)! < Double(ca)! {
                cell.faceHumor.image = UIImage(named: "okface")
            }
        }
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.6847431064, green: 0.8817076683, blue: 0.1245554164, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.3993706107, green: 0.7283234, blue: 0.9620903134, alpha: 1)
        }
        return cell
    }
}
