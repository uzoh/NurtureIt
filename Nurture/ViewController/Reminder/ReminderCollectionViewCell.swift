//
//  ReminderCollectionViewCell.swift
//  Nurture
//
//  Created by Uzoh Okwara on 8/6/21.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReminderCollectionViewCell"
    
    @IBOutlet weak var timeTextView: UIView!
    @IBOutlet weak var timeTextLbl: UILabel!
    
    func setup(text: String, isSelected: Bool) {
        timeTextView.backgroundColor = isSelected ? .systemGray : .appBlue
        layer.cornerRadius = 15
        timeTextLbl.text = String(text)
    }
}
