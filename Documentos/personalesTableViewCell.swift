//
//  personalesTableViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class personalesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundBorderView: UIView!
    @IBOutlet weak var fechaDocumento: UILabel!
    @IBOutlet weak var nombreDocumento: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundBorderView.layer.borderWidth = 1
        backgroundBorderView.layer.borderColor = UIColor.lightGray.cgColor
        backgroundBorderView.layer.cornerRadius = 13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
