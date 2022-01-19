//
//  EmojiViewController.swift
//  Nurture
//
//  Created by Emmanuel Okwara on 31/12/2021.
//

import UIKit

class EmojiViewController: UIViewController {
    
    static var identifier = "EmojiViewController"
    
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    
    private var emo: [String] = ["🛁", "💊", "💉", "🚿", "🎥", "⏰", "✈️", "🎹", "🏋🏽‍♂️", "🧘🏽", "🏊🏼", "🚴🏽", "⛹🏽", "🏇🏽", "🚣🏽", "🏓", "🍲", "🍾", "🚄", "🎤", "🍽", "🍼", "🐕", "🐩", "💍", "💼", "🧶", "👫", "🤱🏽", "🗣", "📍", "👨🏽‍💻", "👩🏽‍💻", "👨🏽‍🍳", "🫂", "💃🏽", "🕺🏽", "🎷", "🎨"]
    
    var selectedItem = ""
    var form: CreateForm!
    var delegate: CreateScheduleDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiCollectionView.reloadData()
        selectedItem = form.emoji
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        form.emoji = selectedItem
        delegate.didAppear()
        dismiss(animated: true, completion: nil)
    }
    
}

extension EmojiViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.identifier, for: indexPath) as! EmojiCollectionViewCell
        let isSelected = selectedItem == emo[indexPath.row]
        cell.setup(text: emo[indexPath.row], isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //This is were the string picked (selected/chosen is assigned)
        selectedItem = emo[indexPath.row]
        collectionView.reloadData()
    }
}


extension EmojiViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

