//
//  messageTableViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 13/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class messageTableViewCell: UITableViewCell {

    @IBOutlet weak var tipe1MessageIcon: UIImageView!
    @IBOutlet weak var type2MessageIcon: UIImageView!
    @IBOutlet weak var messagesBody: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messagesBody.layer.cornerRadius = 14
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
