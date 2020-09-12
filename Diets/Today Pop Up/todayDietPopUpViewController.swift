//
//  todayDietPopUpViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 10/09/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class todayDietPopUpViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var backViewBlue: UIView!
    @IBOutlet weak var backViewWhite: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    let reuseDocument = "DocumentCellPopUp"
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    var Info : Dictionary<String, Any> = [:]
    var dietID : String = ""
    var date : String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        getDate()
        setupTableView()
        setupView()
        getDietInformation()
    }
    
    //MARK: Funcs
    
    func setupView() {
        backViewBlue.layer.cornerRadius = 14
        backViewWhite.layer.cornerRadius = 14
    }
    
    func setupTableView() {
        let documentXib = UINib(nibName: "todaysMenuTableViewCell", bundle: nil)
        tableView!.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    func getDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let result = formatter.string(from: date)
        self.date = result
    }
    
    func getDietInformation() {
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getDailyMenuForDateDiet&id_user="+UserID!+"&date="+date+"&id_diet="+dietID
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, Any> {
                if let data = dictionary["data"] {
                    self.Info = data as! Dictionary<String, Any>
                    self.Info.removeValue(forKey: "Id")
                    print(self.Info.count)
                    print(self.Info)
                    print(self.Info.values)
                }
            }
            DispatchQueue.main.async {
                if self.Info.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
    
    
    @IBAction func closePopUp(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension todayDietPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var Keys = Array(self.Info.keys)[indexPath.row]
        var Values = Array(self.Info.values)[indexPath.row]
        
        func detectWinner() -> String{
            switch (Keys){
            case ("antes_ejercicio"): return "Antes Ejercicio"
            case ("durante"): return "Durante"
            case ("despues"): return "Después"
            case ("desayuno"): return "Desayuno"
            case ("refrigerio"): return "Refrigerio"
            case ("despues_refrigerio"): return "Refrigerio Despues"
            case ("comida"): return "Comida"
            case ("comida_refrigerio"): return "Refrigerio"
            case ("despues_comida_refrigerio"): return "Después"
            case ("cena"): return "Cena"
            default:
                return "Comida"
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath) as! todaysMenuTableViewCell
        
        cell.titleForCell.text = detectWinner()
        cell.descriptionForCell.text = Values as! String
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.6847431064, green: 0.8817076683, blue: 0.1245554164, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.3993706107, green: 0.7283234, blue: 0.9620903134, alpha: 1)
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      //  let document = Info[indexPath.row]
//        let url = document["url"] as! String
//        let varstring = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let urlvarstring = URL(string: varstring!)
//        UIApplication.shared.openURL(urlvarstring!)
//    }
}
