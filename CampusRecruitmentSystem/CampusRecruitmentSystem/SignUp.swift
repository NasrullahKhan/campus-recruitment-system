//
//  ViewController.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 24/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftValidator

class SignUp: UIViewController, ValidationDelegate, UITextFieldDelegate {

    // TextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var marksTextField: UITextField!
    @IBOutlet weak var rollNoTextField: UITextField!
    @IBOutlet weak var mobileNoTextField: UITextField!
    
    // Labels
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var fullNameErrorLabel: UILabel!
    @IBOutlet weak var marksErrorLabel: UILabel!
    @IBOutlet weak var rollNoErrorLabel: UILabel!
    @IBOutlet weak var mobileNoErrorLabel: UILabel!
    
    // Button
    @IBOutlet weak var submitButton: UIButton!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.validator.registerField(self.emailTextField, errorLabel: self.emailErrorLabel, rules: [RequiredRule(), EmailRule()])
        self.validator.registerField(self.passwordTextField, errorLabel: self.passwordErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 6), MaxLengthRule(length: 40)])
        self.validator.registerField(self.fullNameTextField, errorLabel: self.fullNameErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 1), MaxLengthRule(length: 40)])
        self.validator.registerField(self.marksTextField, errorLabel: self.marksErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 6), MaxLengthRule(length: 40)])
        self.validator.registerField(self.rollNoTextField, errorLabel: self.rollNoErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 6), MaxLengthRule(length: 40)])
        self.validator.registerField(self.mobileNoTextField, errorLabel: self.mobileNoErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 6), MaxLengthRule(length: 40)])
        
        self.validator.styleTransformers(success:{ (validationRule) -> Void in
            // clear error label
            
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            
        }, error:{ (validationError) -> Void in
            
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
           
        })

    }

    @IBAction func submitTapped(_ sender: Any) {
        
        self.validator.validate(self)
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        
        self.view.showHud()
        
        FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
            
            self.view.hideHud()
            
            guard let _ = user else {
                self.showAlert(title: "Error", msg: error!.localizedDescription)
                return
            }
            
            let mainController = self.storyboard?.instantiateViewController(withIdentifier: "MainControllerIdentifier") as! MainViewController
            self.present(mainController, animated: true, completion: nil)
        })
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

