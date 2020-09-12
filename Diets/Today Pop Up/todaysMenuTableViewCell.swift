//
//  todaysMenuTableViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 11/09/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class todaysMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleForCell: UILabel!
    @IBOutlet weak var descriptionForCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
