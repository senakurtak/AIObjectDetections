//
//  LogInViewController.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 4.04.2023.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logIn(_ sender: Any) {
        if emailTextField.text != "" {
            if passwordTextField.text != "" {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in}
                let mainVC = MainViewController()
                mainVC.modalPresentationStyle = .fullScreen
                present(mainVC,animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Email must not be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel))
            present(alert, animated: true)
        }
    }
}
