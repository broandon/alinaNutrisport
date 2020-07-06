//
//  recoverViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 24/04/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

//MARK: Outlets

let http = HTTPViewController()

class recoverViewController: UIViewController {
    
    @IBOutlet weak var mailTF: UITextField!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Funcs
    
    func setupView() {
        mailTF.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(named: "Main Green")!, width: 3)
    }
    
    //MARK: Actions
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func recoverAccount(_ sender: Any) {
        
        if mailTF.text?.isEmpty == true {
            let alert = UIAlertController(title: "El campo de correo no puede estar vacío", message: "Ingresa tu correo electrónico.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        if mailTF.text?.contains("@") == true {
            print("This is an email")
        } else {
            let alert = UIAlertController(title: "Error en tu correo", message: "¿Has ingresado un correo válido?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        view.endEditing(true)
        let alert = UIAlertController(title: nil, message: "   Espera un momento...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        let url = URL(string: http.baseURL())!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=recoverAccount&email="+mailTF.text!
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let recoverResponse = try? JSONDecoder().decode(RecoverResponse.self, from: data)
                    print("This is the status Message")
                    print(recoverResponse?.statusMsg ?? "No response")
                    print("This is the state")
                    print(recoverResponse?.state ?? "No response")
                    
                    if recoverResponse?.state == "200" {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: {
                                let alert = UIAlertController(title: "¡Éxito!", message: "A tu correo llegará un enlace para recuperar tu contraseña", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Entendido", style: .cancel, handler: { action in
                                    self.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true)
                            })
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: {
                                let alert = UIAlertController(title: "Error", message: "Ha habido un error en el servidor o no hemos encontrado tu correo", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
                                self.present(alert, animated: true)
                                return
                            })
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
