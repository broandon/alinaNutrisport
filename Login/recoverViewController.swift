//
//  recoverViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 24/04/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class recoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        

    }
    
    @IBAction func popUp(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "¡Listo!", message: "Se ha enviado un mensaje a tu correo electronico para recuperar tu contraseña.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         
        self.present(alert, animated: true)
        
    }
    


}
