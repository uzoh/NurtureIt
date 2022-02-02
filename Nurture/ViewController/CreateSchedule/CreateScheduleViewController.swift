//
//  CreateScheduleViewController.swift
//  Nurture
//
//  Created by Uzoh Okwara on 4/28/21.
//

import UIKit
import ProgressHUD

protocol CreateScheduleDelegate {
    func didAppear()
}

class CreateScheduleViewController: UIViewController {
    
    @IBOutlet weak var trashBtn: UIBarButtonItem!
    @IBOutlet weak var createTitle: UITextField!
    @IBOutlet weak var reminderArrowBtn: UIButton!
    @IBOutlet weak var taskDaysLabel: UILabel!
    @IBOutlet weak var reminderLbl: UILabel!
    @IBOutlet weak var emojiLbl: UILabel!
    
    var isNew: Bool = false
    var form = CreateForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTitle.text = form.title
        didAppear()
    }
    
    func goToSelectDayPage() {
        let controller = storyboard?.instantiateViewController(identifier: "CustomiseScheduleViewController") as! CustomiseScheduleViewController
        controller.form = form
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func goToReminder() {
        let controller = storyboard?.instantiateViewController(identifier: "NotificationViewController") as! NotificationViewController
        controller.form = form
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func goToEmojis() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "EmojiViewController") as! EmojiViewController
        controller.form = form
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func selectedDays() {
        if form.days.isEmpty{
            taskDaysLabel.text = "Select Day(s)"
        } else {
            taskDaysLabel.text = String("\(form.days.count)day(s) selected")
        }
    }
    
    func selectedReminder() {
        if form.time.isEmpty{
            reminderLbl.text = "Select time(s)"
        } else {
            reminderLbl.text = String("\(form.time.count)time(s) selected")
        }
    }
    
    func selectedEmoji() {
        if form.emoji.isEmpty{
            emojiLbl.text = "Select Emoji"
        } else {
            emojiLbl.text = form.emoji
        }
    }
    
    func deletePressed() {
        
        let alert = UIAlertController(title: "Delete Habit", message: "Sure you want to delete?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Delete", style: .default) { (action) in
            // what will happen when the user clicks the Add buttion in the UIAlert
            
            ProgressHUD.show("Deleting Habit...")
            NetworkService.shared.deleteHabit(self.form) { [weak self] result in
                switch result {
                case .success(let message):
                    ProgressHUD.showSucceed(message)
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
                }
            }
        }
        let anotherAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // what will happen when the user clicks the Add buttion in the UIAlert
           
        }
        
        alert.addAction(action)
        alert.addAction(anotherAction)
        present(alert, animated: true, completion: nil)
    }
        
    
    func savePressed() {
        let title = createTitle.text
        form.title = title!
        if title == "" {
            ProgressHUD.showError("Fill your Title")
        } else if form.days.isEmpty {
            ProgressHUD.showError("Select the Days")
        } else if form.time.isEmpty {
            ProgressHUD.showError("Select the Time")
        } else {
            if isNew {
                ProgressHUD.show("Creating Habit...")
                NetworkService.shared.createHabit(form) { [weak self] result in
                    switch result {
                    case .success(let message):
                        ProgressHUD.showSucceed(message)
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        ProgressHUD.showError(error.localizedDescription)
                    }
                }
            } else {
                ProgressHUD.show("Updating Habit...")
                NetworkService.shared.updateHabit(form) { [weak self] result in
                    switch result {
                    case .success(let message):
                        ProgressHUD.showSucceed(message)
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        ProgressHUD.showError(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func trashBtnClicked(_ sender: UIBarButtonItem) {
        deletePressed()
    }
    
    @IBAction func selectDaysClicked(_ sender: UIButton) {
        goToSelectDayPage()
    }
    
    @IBAction func selectReminderClicked(_ sender: UIButton) {
        goToReminder()
    }
    
    @IBAction func selectEmojisClicked(_ sender: UIButton) {
        goToEmojis()
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        savePressed()
    }
}

extension CreateScheduleViewController: CreateScheduleDelegate {
    func didAppear() {
        selectedDays()
        selectedReminder()
        selectedEmoji()
    }
}
extension UIBarButtonItem {
    var isHidden: Bool {
        get {
            return !isEnabled && tintColor == .clear
        } set {
            tintColor = newValue ? .clear : nil
            isEnabled = !newValue
        }
    }
}

// TODO
//1. Change Everyday to "Select Days" when no day is selected and "n days selected" when days have been selected "n" is the count of days array
//2. Add a cancel button in the reminder page
//3. Change Everyday to "Select times" when no day is selected and "n times selected" when time have been selected "n" is the count of days array
//4. Remove nickname in choose days page and remove the title
//5. when you come back to a page prepopulate the days with what was selected


//Jan 13 / 21
// add delete button to top of createSchedule nav bar
// remove the create header if its on update
// if its new hide button else show delete
// how to delete a document from fire store
// on success return to previous page
