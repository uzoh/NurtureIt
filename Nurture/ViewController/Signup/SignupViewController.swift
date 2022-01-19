//
//  SignupViewController.swift
//  Nurture
//
//  Created by Uzoh Okwara on 2/23/21.
//

import UIKit
import Firebase
import ProgressHUD

class SignupViewController: UIViewController {

    @IBOutlet weak var signupEmailField: UITextField!
    @IBOutlet weak var passwordEmailField: UITextField!
    @IBOutlet weak var confirmPasswordEmailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func goToDashBoard() {
        ProgressHUD.dismiss()
        let controller = storyboard?.instantiateViewController(identifier: "Nav") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
    func signup() {
        NetworkService.shared.register(email: signupEmailField.text!, password: passwordEmailField.text!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.goToDashBoard()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        //goToDashBoard()
    }

    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        
        
        if signupEmailField.text?.isEmpty == true {
            ProgressHUD.showError("Enter your email...")
            return
        }
        
        if passwordEmailField.text?.isEmpty == true {
            ProgressHUD.showError("Enter your password...")
            return
        }
        
        if confirmPasswordEmailField.text?.isEmpty == true {
            ProgressHUD.showError("Confirm your password!")
            return
        }
        
        if passwordEmailField.text != confirmPasswordEmailField.text {
            ProgressHUD.showError("Error...Password doesn't match!!!")
            return
        }
        signup()
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
