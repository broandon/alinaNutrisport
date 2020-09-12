//
//  dietsCollectionViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

protocol dietButtonAction {
    func showTodaysMenu(idNumber:String)
    func showAllMenu(URL:String)
}

class dietsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var todaysMenuButton: UIButton!
    @IBOutlet weak var completeMenuButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    
    var delegate : dietButtonAction!
    let cellIdentifier = "dietsCollectionViewCell"
    var cellURL = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    func configureCell(){
        todaysMenuButton.layer.cornerRadius = 9
        completeMenuButton.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 3.5
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.cornerRadius = 15
    }
    
    @IBAction func showTodaysDiet(_ sender: UIButton) {
        let dietID = "\(sender.tag)"
        self.delegate.showTodaysMenu(idNumber: dietID)
    }
    
    @IBAction func showAllDiet(_ sender: Any) {
        let URLToVisit = self.cellURL
        self.delegate.showAllMenu(URL: URLToVisit)
    }
}
