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
    
    private var emo: [String] = ["๐", "๐", "๐", "๐ฟ", "๐ฅ", "๐ธ", "โฐ", "โ๏ธ", "๐น", "๐๐ฝโโ๏ธ", "๐ง๐ฝ", "๐๐ผ", "๐ด๐ฝ", "โน๐ฝ", "๐๐ฝ", "๐ฃ๐ฝ", "๐", "๐ฒ", "๐พ", "๐", "๐ค", "๐ฝ", "๐ผ", "๐", "๐ฉ", "๐", "๐ผ", "๐งถ", "๐ซ", "๐คฑ๐ฝ", "๐ฃ", "๐", "๐จ๐ฝโ๐ป", "๐ฉ๐ฝโ๐ป", "๐จ๐ฝโ๐ณ", "๐ซ", "๐๐ฝ", "๐บ๐ฝ", "๐ท", "๐จ", "๐บ", "๐ฅ", "๐๐ฝโโ๏ธ", "๐", "๐ช", "๐น", "โธ", "๐น", "๐ฅ", "๐ฅ", "๐คผโโ๏ธ", "๐ฑ", "๐", "โฝ๏ธ", "๐พ", "๐", "โท", "๐ผ", "๐ง๐ฝ", "๐ฒ", "๐ณ", "๐ฎ", "๐ป", "๐ฏ", "๐", "๐ฅ", "๐", "๐ค", "๐", "๐ก", "๐", "๐"]
    
    var selectedItem = ""
    var form: CreateForm!
    var delegate: CreateScheduleDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emo = emo.shuffled()
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

