//
//  RegisterViewController.swift
//  FirebaseDemo
//
//  Created by Rani Singh on 08/04/20.
//  Copyright © 2020 InnoCric. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBActions
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
                
            }
        }
    }
    
}
