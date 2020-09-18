//
//  dailyInfoTableViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 12/09/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

protocol addAndSubstractFood {
    func updateDailyMenuDiet(menuID:String, quantity:String)
}

class dailyInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var EqLabel: UILabel!
    @IBOutlet weak var caLabel: UILabel!
    @IBOutlet weak var faceHumor: UIImageView!
    
    var delegate : addAndSubstractFood!
    var menuID: String = ""
    var firstQuantity: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func addValue(_ sender: Any) {
        let comparableQuantity = Double("\(firstQuantity)")
        let firstValue = Double("\(caLabel.text ?? "0")")
        let nextValue = firstValue! + 0.5
        let updatedValue = "\(nextValue)"
        caLabel.text = updatedValue
        self.delegate.updateDailyMenuDiet(menuID: menuID, quantity: updatedValue)
        if comparableQuantity! > nextValue {
            faceHumor.image = UIImage(named: "okface")
        }
        if comparableQuantity == nextValue {
            faceHumor.image = UIImage(named: "hungyface")
        }
        if comparableQuantity! < nextValue{
            faceHumor.image = UIImage(named: "passed")
        }
        UserDefaults.standard.set(false, forKey: "isItZero")
    }
    
    @IBAction func substrackValue(_ sender: Any) {
        let comparableQuantity = Double("\(firstQuantity)")
        let firstValue = Double("\(caLabel.text ?? "0")")
        let nextValue = firstValue! - 0.5
        let updatedValue = "\(nextValue)"
        //   caLabel.text = updatedValue
        if updatedValue == "0.0" {
            caLabel.text = "0"
            UserDefaults.standard.set(true, forKey: "isItZero")
        }
        if UserDefaults.standard.bool(forKey: "isItZero") == false {
            caLabel.text = updatedValue
            self.delegate.updateDailyMenuDiet(menuID: menuID, quantity: updatedValue)
            if comparableQuantity! > nextValue {
                faceHumor.image = UIImage(named: "okface")
            }
            if comparableQuantity == nextValue {
                faceHumor.image = UIImage(named: "hungyface")
            }
            if comparableQuantity! < nextValue{
                faceHumor.image = UIImage(named: "passed")
            }
        }
        if UserDefaults.standard.bool(forKey: "isItZero") == true {
            print("Nothing")
        }
    }
}
