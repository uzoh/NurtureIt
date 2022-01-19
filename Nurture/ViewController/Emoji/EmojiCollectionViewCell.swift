//
//  EmojiCollectionViewCell.swift
//  Nurture
//
//  Created by Emmanuel Okwara on 31/12/2021.
//

import UIKit
import Accelerate

class EmojiCollectionViewCell: UICollectionViewCell {
    static let identifier = "EmojiCollectionViewCell"
    
    @IBOutlet weak var emojiView: UIView!
    @IBOutlet weak var emojiLbl: UILabel!
    
    func setup(text: String, isSelected: Bool) {
        emojiView.backgroundColor = isSelected ? .systemGray : .appBlue
        layer.cornerRadius = 15
        
        emojiLbl.text = String(text)
    }
    
}

