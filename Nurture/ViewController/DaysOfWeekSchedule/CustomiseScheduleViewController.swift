//
//  TaskDaysViewController.swift
//  Nurture
//
//  Created by Uzoh Okwara on 5/16/21.

// Create an array for all selected items
// function called when buttons are clicked
// Fucntion to update the background color of button
// When a button is clicked you want to add the button title to the array then call the update background color function

import UIKit

class CustomiseScheduleViewController: UIViewController {
   
    @IBOutlet weak var sundayWeekBtn: UIButton!
    @IBOutlet weak var mondayWeekBtn: UIButton!
    @IBOutlet weak var tuesdayWeekBtn: UIButton!
    @IBOutlet weak var wednesdayWeekBtn: UIButton!
    @IBOutlet weak var thursdayWeekBtn: UIButton!
    @IBOutlet weak var fridayWeekBtn: UIButton!
    @IBOutlet weak var saturdayWeekBtn: UIButton!
    
    var selectedItems = [String]()
    var form: CreateForm!
    
    var delegate: CreateScheduleDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedItems = form.days

        for day in selectedItems {
            switch day {
            case "Sunday":
                updateButtonBackground(sundayWeekBtn, isSelected: true)
            case "Monday":
                updateButtonBackground(mondayWeekBtn, isSelected: true)
            case "Tuesday":
                updateButtonBackground(tuesdayWeekBtn, isSelected: true)
            case "Wednesday":
                updateButtonBackground(wednesdayWeekBtn, isSelected: true)
            case "Thursday":
                updateButtonBackground(thursdayWeekBtn, isSelected: true)
            case "Friday":
                updateButtonBackground(fridayWeekBtn, isSelected: true)
            case "Saturday":
                updateButtonBackground(saturdayWeekBtn, isSelected: true)
            default:
                break;
            }
        }
    }

    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func weeksOption(_ sender: UIButton) {
        
        if let index = selectedItems.firstIndex (of: sender.title(for: .normal) ?? "") {
            selectedItems.remove(at: Int(index))
            updateButtonBackground(sender, isSelected: false)
        } else {
            selectedItems.append(sender.title(for: .normal) ?? "")
            updateButtonBackground(sender, isSelected: true)
        }
    }
    
    func updateButtonBackground(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = .appBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 15
            
        } else {
            button.backgroundColor = .clear
            button.setTitleColor(.appBlue, for: .normal)
        }
        //Alternative code
       // button.backgroundColor = isSelected ? .systemBlue : .white
    }
    
    @IBAction func DoneBtnPressed(_ sender: Any) {
        form.days = []
        for day in selectedItems {
            form.days.append(day)
        }
        delegate.didAppear()
        dismiss(animated: true, completion: nil)
    }
}


