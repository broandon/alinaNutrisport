//
//  dailyTrackingViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 12/09/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class dailyTrackingViewController: UIViewController {
    
    @IBOutlet weak var upperDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var previousDateButton: UIButton!
    @IBOutlet weak var nextDateButton: UIButton!
    @IBOutlet weak var mainViewBackground: UIView!
    
    let reuseDocument = "DocumentCell3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let documentXib = UINib(nibName: "dailyInfoTableViewCell", bundle: nil)
        tableView!.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = true
    }

    func setupView() {
        mainViewBackground.layer.cornerRadius = 15
        mainViewBackground.layer.borderColor = UIColor.lightGray.cgColor
        mainViewBackground.layer.borderWidth = 0.5
    }

}

extension dailyTrackingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.6847431064, green: 0.8817076683, blue: 0.1245554164, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.3993706107, green: 0.7283234, blue: 0.9620903134, alpha: 1)
        }

        return cell
    }
    
    
}
