//
//  ViewController.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 24/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit
import SwiftValidator

class CompanySignUp: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    // TextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var agentNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    // Labels
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var agentNameErrorLabel: UILabel!
    @IBOutlet weak var companyNameErrorLabel: UILabel!
    @IBOutlet weak var descriptionErrorLabel: UILabel!
    @IBOutlet weak var contactErrorLabel: UILabel!
    @IBOutlet weak var addressErrorLabel: UILabel!
    
    // Button
    @IBOutlet weak var submitButton: UIButton!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.validator.registerField(self.emailTextField, errorLabel: self.emailErrorLabel, rules: [RequiredRule(), EmailRule()])
        self.validator.registerField(self.passwordTextField, errorLabel: self.passwordErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 6), MaxLengthRule(length: 40)])
        self.validator.registerField(self.agentNameTextField, errorLabel: self.agentNameErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 1), MaxLengthRule(length: 40)])
        self.validator.registerField(self.companyNameTextField, errorLabel: self.companyNameErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 1), MaxLengthRule(length: 40)])
        self.validator.registerField(self.descriptionTextField, errorLabel: self.descriptionErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 1), MaxLengthRule(length: 40)])
        self.validator.registerField(self.contactTextField, errorLabel: self.contactErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 1), MaxLengthRule(length: 40)])
        self.validator.registerField(self.addressTextField, errorLabel: self.addressErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 1), MaxLengthRule(length: 40)])

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
        
        let company = Company(address: self.addressTextField.text!, companyName: self.companyNameTextField.text!, description: self.descriptionTextField.text!, email: self.emailTextField.text!, name: self.agentNameTextField.text!, contactNo: self.addressTextField.text!, userType: .company, password: self.passwordTextField.text!)
        
        Auth.createCompany(company: company) { (error) in
            
            self.view.hideHud()
            
            if error != nil {
                self.showAlert(title: "Error", msg: error!)
            }else {
                self.showAlert(title: "Success", msg: "Student Registred Successfully, go to Login Screen and sign in")
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

