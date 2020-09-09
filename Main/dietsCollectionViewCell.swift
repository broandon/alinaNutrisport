//
//  dietsCollectionViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class dietsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var todaysMenuButton: UIButton!
    @IBOutlet weak var completeMenuButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        todaysMenuButton.layer.cornerRadius = 5
        completeMenuButton.layer.cornerRadius = 5
    }

}
