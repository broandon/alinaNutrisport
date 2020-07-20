//
//  datesViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import FSCalendar

class datesViewController: UIViewController {
    
    @IBOutlet weak var logoBackround: UIView?
    @IBOutlet weak var logoImage: UIImageView?
    @IBOutlet weak var containerView1Dates: UIView?
    @IBOutlet weak var containerView2Calendar: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var calendarView: UIView?
    
    var appointments: [Dictionary<String, Any>] = []
    let reuseDocument = "DocumentCell3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        downloadJson()
        let documentXib = UINib(nibName: "datesTableViewCell", bundle: nil)
        tableView?.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.allowsSelection = false
    }
    
    func setupView() {
        logoBackround?.layer.backgroundColor = UIColor.white.cgColor
        logoBackround?.layer.borderColor = UIColor.lightGray.cgColor
        logoBackround?.layer.borderWidth = 0.0
        logoBackround?.layer.cornerRadius = 84.5
        logoBackround?.layer.masksToBounds = false
        logoBackround?.layer.shadowRadius = 3.5
        logoBackround?.layer.shadowColor = UIColor.gray.cgColor
        logoBackround?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackround?.layer.shadowOpacity = 1.0
        logoImage?.layer.backgroundColor = UIColor.white.cgColor
        logoImage?.layer.borderColor = UIColor.lightGray.cgColor
        logoImage?.layer.borderWidth = 0.0
        logoImage?.layer.cornerRadius = 84.5
        logoImage?.layer.masksToBounds = true
        
        containerView1Dates?.alpha = 0
        containerView2Calendar?.alpha = 1
    }
    
    @IBAction func changedSection(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            containerView1Dates?.alpha = 0
            containerView2Calendar?.alpha = 1
        }
        
        if sender.selectedSegmentIndex == 1 {
            containerView1Dates?.alpha = 1
            containerView2Calendar?.alpha = 0
        }
        
    }
    
    func downloadJson() {
        
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getAppointments&id_user=1"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            
            do {
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
                
            }
            
        }.resume()
    }
    
    @IBAction func getOut(_ sender: Any) {
        
        self.hero.isEnabled = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        
        self.hero.replaceViewController(with: newViewController)
        
    }
    
}

extension datesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appointments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let document = appointments[indexPath.row]
        
        
        let fecha  = document["fecha"] as? String ?? ""
        let tipoCita = document["tipo_cita"] as? String ?? ""
        let estatus = document["estatus"] as? String ?? ""
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath)
        
        if let cell = cell as? datesTableViewCell
            
        {
            DispatchQueue.main.async {
                
                cell.fecha.text = fecha
                cell.tipoTratamiento.text = "Tratamiento"
                cell.tratamiento.text = "Agendada"
                
            }
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    
    
    
}
