//
//  MultiplayerCardCollectionViewCell.swift
//  SwiftShot
//
//  Created by Paulo Santos on 26/12/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class MultiplayerCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        self.imageView.layer.borderColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0).cgColor
    
    }
}
