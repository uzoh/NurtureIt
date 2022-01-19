//
//  HabitCollectionViewCell.swift
//  Nurture
//
//  Created by Uzoh Okwara on 7/10/21.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: HabitCollectionViewCell.self)
    
    @IBOutlet weak var habitEmojiLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    func setup(with dashboard: CreateForm) {
        habitEmojiLbl.text = dashboard.emoji
        titleLbl.text = dashboard.title
    }
    
    func setupNew() {
        habitEmojiLbl.text = "➕"
        titleLbl.text = "New Habit"
        //titleLbl.textColor = UIColor.appBlue
    }
}
