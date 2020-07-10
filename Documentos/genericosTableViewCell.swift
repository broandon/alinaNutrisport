//
//  genericosTableViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class genericosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wayBack: UIView!
    @IBOutlet weak var fechaGenerico: UILabel!
    @IBOutlet weak var nombreGenerico: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wayBack.layer.borderColor = UIColor.lightGray.cgColor
        wayBack.layer.borderWidth = 1.0
        wayBack.layer.cornerRadius = 13
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
