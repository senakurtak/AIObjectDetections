//
//  RegisterViewController.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 4.04.2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func register(_ sender: Any) {
        
        if emailTextField.text != "" {
            if passwordTextField.text != "" {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in}
                
                let alert = UIAlertController(title: "Success", message: "Sign Up Succesfull.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                present(alert, animated: true)
                let registeredScreen = RegisteredViewController()
                present(registeredScreen, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "Password must not be empty ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Email must not be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true

    }
}
