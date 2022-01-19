//
//  ViewController.swift
//  Nurture
//
//  Created by Uzoh Okwara on 2/23/21.
//

import UIKit
import FirebaseAuth
import ProgressHUD
//import AuthenticationServices

class LoginViewController: UIViewController {

    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    //private let appleButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func appleButton(_ sender: UIButton) {
    }
    
    func goToDashboard() {
        ProgressHUD.dismiss()
        let controller = storyboard?.instantiateViewController(identifier: "Nav") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
    func goToSignupfunc() {
        let controller = storyboard?.instantiateViewController(identifier: "SignupViewController") as! SignupViewController
        //controller.modalPresentationStyle = .Fullscreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
    func validateFields() {
        if loginEmailField.text?.isEmpty == true {
            ProgressHUD.showError("Enter your email...")
            return
        }
        
        if loginPasswordField.text?.isEmpty == true {
            ProgressHUD.showError("Enter your password...")
            return
        }
        login()
        ProgressHUD.show()
    }
    
    func login() {
        NetworkService.shared.login(email: loginEmailField.text!, password: loginPasswordField.text!) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(_):
                self.checkUserInfo()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            goToDashboard()
        }
    }
    
    @IBAction func goToSignup(_ sender: UIButton) {
        goToSignupfunc()
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
         validateFields()
    }
    
}

