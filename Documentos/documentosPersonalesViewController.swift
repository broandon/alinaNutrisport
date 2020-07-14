//
//  documentosPersonalesViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class documentosPersonalesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appointments: [Dictionary<String, Any>] = []
    let reuseDocument = "DocumentCell3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON()
        let documentXib = UINib(nibName: "personalesTableViewCell", bundle: nil)
        tableView!.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = true
    }
    
    func downloadJSON() {
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getGenericDocuments&id_user=1"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, Any> {
                for d in dictionary["data"] as! [Dictionary<String, Any>] {
                    print(d)
                    self.appointments.append(d)
                    
                }
            }
            DispatchQueue.main.async {
                
                if self.appointments.count > 0 {
                    self.tableView?.reloadData()
                }
            }
        }.resume()
    }
}

extension documentosPersonalesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appointments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let document = appointments[indexPath.row]
        let fecha  = document["fecha"] as? String ?? ""
        let nombre = document["nombre"] as? String ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath)
        cell.selectionStyle = .none
        if let cell = cell as? personalesTableViewCell {
            DispatchQueue.main.async {
                cell.nombreDocumento.text = nombre
                cell.fechaDocumento.text = fecha
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let document = appointments[indexPath.row]
        let url = document["url"] as! String
        let varstring = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlvarstring = URL(string: varstring!)
        UIApplication.shared.open(urlvarstring!)
    }
}
