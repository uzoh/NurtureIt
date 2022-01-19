//
//  DashBoardViewController.swift
//  Nurture
//
//  Created by Uzoh Okwara on 5/19/21.
//

import UIKit
import Firebase
import ProgressHUD

class DashBoardViewController: UIViewController {

    @IBOutlet weak var habitCollectionView: UICollectionView!
    var dashboard: [CreateForm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        habitCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        registerCells()
    }
    @IBAction func logoutBtn(_ sender: UIBarButtonItem) {
        logoutTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkService.shared.fetchHabits { [weak self] result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let habits):
                self?.dashboard = habits
                self?.habitCollectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    func goBackToLogin() {
     
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func logoutTapped() {
        do {
            try Auth.auth().signOut()
            goBackToLogin()
        } catch {
            ProgressHUD.showError("An error occured")
        }
    }
    
    private func registerCells() {
        habitCollectionView.register(UINib(nibName: HabitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
    }

}

extension DashBoardViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboard.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
        
        if indexPath.row == 0 {
            cell.setupNew()
        } else {
            cell.setup(with: dashboard[indexPath.row - 1])
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexRow = indexPath.row
        if indexRow == 0 {
            let controller = self.storyboard?.instantiateViewController(identifier: "CreateScheduleViewController") as! CreateScheduleViewController
            controller.isNew = true
            controller.title = "Create New Habit"
            controller.trashBtn.isEnabled = false
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let row = indexRow - 1
            let controller = self.storyboard?.instantiateViewController(identifier: "CreateScheduleViewController") as! CreateScheduleViewController
            controller.isNew = false
            controller.title = "Edit Habit"
            controller.trashBtn.isEnabled = true
            controller.form = dashboard[row]
            self.navigationController?.pushViewController(controller, animated: true)
            
//            print(dashboard[row].title)
//            print(dashboard[row].emoji)
        }
    }
}

extension DashBoardViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 200)
    }
}
