//
//  sectionsCollectionViewCell.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 02/04/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit

class sectionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var sectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        background.layer.backgroundColor = UIColor.white.cgColor
        background.layer.borderColor = UIColor.lightGray.cgColor
        background.layer.borderWidth = 0.0
        background.layer.cornerRadius = 15
        background.layer.masksToBounds = false
        background.layer.shadowRadius = 3.5
        background.layer.shadowColor = UIColor.gray.cgColor
        background.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        background.layer.shadowOpacity = 1.0
    }
}
