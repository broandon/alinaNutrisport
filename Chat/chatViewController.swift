//
//  chatViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 13/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class chatViewController: UIViewController {
    
    var messages: [Dictionary<String, Any>] = []
    let reuseDocument = "DocumentCellMessages"
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
    @IBOutlet weak var logoBackground: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        setupView()
        let documentXib = UINib(nibName: "messageTableViewCell", bundle: nil)
        tableView!.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = true
        tableView.transform = CGAffineTransform(rotationAngle: (-.pi))
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.size.width - 10)
    }
    
    func setupView() {
        logoBackground?.layer.backgroundColor = UIColor.white.cgColor
        logoBackground?.layer.borderColor = UIColor.lightGray.cgColor
        logoBackground?.layer.borderWidth = 0.0
        logoBackground?.layer.cornerRadius = (logoBackground?.bounds.height ?? 50) / 2
        logoBackground?.layer.masksToBounds = true
        logoBackground?.layer.shadowRadius = 3.5
        logoBackground?.layer.shadowColor = UIColor.gray.cgColor
        logoBackground?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackground?.layer.shadowOpacity = 1.0
        logo?.layer.backgroundColor = UIColor.white.cgColor
        logo?.layer.borderColor = UIColor.lightGray.cgColor
        logo?.layer.borderWidth = 0.0
        logo?.layer.cornerRadius = (logo?.bounds.height ?? 50) / 2
        logo?.layer.masksToBounds = true
        logo?.layer.shadowRadius = 3.5
        logo?.layer.shadowColor = UIColor.gray.cgColor
        logo?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logo?.layer.shadowOpacity = 1.0
    }
    
    
    func downloadJson() {
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getMessages&id_user="+UserID!
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let dictionary = json as? Dictionary<String, Any> {
                for d in dictionary["data"] as! [Dictionary<String, Any>] {
                    print(d)
                    self.messages.append(d)
                }
            }
            DispatchQueue.main.async {
                if self.messages.count > 0 {
                    self.tableView?.reloadData()
                }
            }
            
        }.resume()
    }
    @IBAction func sendMessage(_ sender: Any) {
        
        if messageText.text?.isEmpty == true {
            print("No text.")
            return
        }
        
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=sendMessage&id_user="+UserID!+"&message="+messageText.text!
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response != nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let dictionary = json as? Dictionary<String, Any> {
                if let state = dictionary["state"] {
                    print(state)
                    
                    let stateNumber = state as! String
                    
                    if stateNumber == "200" {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.3, animations: {
                                self.messages.removeAll()
                                self.downloadJson()
                                self.tableView.reloadData()
                                self.messageText.text = ""
                            })
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                if self.messages.count > 0 {
                    self.tableView?.reloadData()
                }
            }
        }.resume()
    }
    
    @IBAction func getOut(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
}

extension chatViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messageText.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath) as? messageTableViewCell else {
            return UITableViewCell()
        }
        
        messages.sort { ($0["Id"] as! String) > ($1["Id"] as! String) }
        
        let document = messages[indexPath.row]
        let ID  = document["Id"] as? String ?? ""
        let Mensaje = document["mensaje"] as? String ?? ""
        let Fecha = document["fecha"] as? String ?? ""
        let Tipo = document["Tipo"] as? String ?? ""
        
        if Tipo == "1" {
            cell.messagesBody.backgroundColor = #colorLiteral(red: 0.3819331229, green: 0.6950346828, blue: 0.01693408191, alpha: 1)
            cell.tipe1MessageIcon.isHidden = true
            cell.type2MessageIcon.isHidden = false
        }
        
        if Tipo == "2" {
            cell.messagesBody.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            cell.type2MessageIcon.isHidden = true
            cell.tipe1MessageIcon.isHidden = false
        }
        
        cell.dateLabel.text = Fecha
        cell.mainMessageLabel.text = Mensaje
        cell.transform = CGAffineTransform(rotationAngle: (-.pi))
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
}
