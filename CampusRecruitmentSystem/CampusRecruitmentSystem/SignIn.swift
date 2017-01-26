//
//  SignIn.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 24/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftValidator

class SignIn: UIViewController, ValidationDelegate, UITextFieldDelegate  {
    
    // TextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Labels
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    // Button
    @IBOutlet weak var loginButton: UIButton!

    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule()])
        self.validator.registerField(passwordTextField, errorLabel: passwordErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 6), MaxLengthRule(length: 40)])
        
        self.validator.styleTransformers(success:{ (validationRule) -> Void in
            // clear error label
            
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            
        }, error:{ (validationError) -> Void in
            
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            
        })
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        self.validator.validate(self)
        
    }

    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        
        self.view.showHud()

        Auth.login(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            
            self.view.hideHud()
            
            if error == nil {
                
                if let _ = user as? Student {
                    
                    self.performSegue(withIdentifier: "goToStudentMainVC", sender: nil)
                    
                }else if let _ = user as? Company {
                    
                    self.performSegue(withIdentifier: "goToCompanyVC", sender: nil)
                }
            }
        }
        
        
    }
    
    func validationFailed(_ errors:[(Validatable, ValidationError)]) {
        
    }
    
    // MARK: TextField Delegate Methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.validator.validateField(textField){ error in
            if error == nil {
                // Field validation was successful
            } else {
                // Validation error occurred
            }
        }
    }

    

}
