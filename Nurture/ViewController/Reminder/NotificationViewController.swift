//
//  NotificationViewController.swift
//  Nurture
//
//  Created by Uzoh Okwara on 5/16/21.
//

import UIKit

class NotificationViewController: UIViewController {
    
    static var identifier = "NotificationViewController"

    @IBOutlet weak var reminderCollectionView: UICollectionView!
    
    private var durations: [String] = []
    
    var selectedItems2 = [String]()
    var form: CreateForm!
    var delegate: CreateScheduleDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for time in 1 ... 24 {
            if time <= 12 {
                durations.append("\(time) am")
            } else {
                durations.append("\(time - 12) pm")
            }
        }
        reminderCollectionView.reloadData()
        
        selectedItems2 = form.time
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func NotificationBtn(_ sender: UIButton) {
        form.time = []
        for time in selectedItems2 {
            form.time.append(time)
        }
        delegate.didAppear()
        dismiss(animated: true, completion: nil)
    }
    
}

extension NotificationViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return durations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderCollectionViewCell.identifier, for: indexPath) as! ReminderCollectionViewCell
        let isSelected = selectedItems2.first { $0 == durations[indexPath.row] } != nil
        cell.setup(text: durations[indexPath.row], isSelected: isSelected)
        return cell
    }
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = selectedItems2.firstIndex(of: durations[indexPath.row]) {
            selectedItems2.remove(at: Int(index))
        } else {
            selectedItems2.append(durations[indexPath.row])
        }
        collectionView.reloadData()
    }
}

extension NotificationViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
}

