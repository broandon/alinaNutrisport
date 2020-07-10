//
//  datesTableViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class datesTableViewCell: UITableViewCell {

    @IBOutlet weak var someViewIDontKnow: UIView!
    
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var tratamiento: UILabel!
    @IBOutlet weak var tipoTratamiento: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        someViewIDontKnow.layer.borderColor = UIColor.lightGray.cgColor
        someViewIDontKnow.layer.borderWidth = 1.0
        someViewIDontKnow.layer.cornerRadius = 13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
