//
//  trackingsTableViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 13/10/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class trackingsTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var numberOfLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
