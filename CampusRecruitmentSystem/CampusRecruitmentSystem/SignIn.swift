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
        
        self.view.showHud()
        
        Auth.login(email: "s@pc.com", password: "123456") { (user, error) in
            
            self.view.hideHud()
            
            if error == nil {
                
                if let student = user as? Student {
                    
                    let mainController = self.storyboard!.instantiateViewController(withIdentifier: "StudentMainVCIdentifier") as! StudentMainVC
                    self.present(mainController, animated: true, completion: nil)
                    
//                    RequestsServices.applyPost(cID: "-KbPDicz0yJnUNomZUWO", postID: "-KbPERWoXqD0PNs_CO7I", userID: student.uID!, completion: { (error) in
//                        if error != nil {
//                        
//                        }else {
//                        
//                        }
//                    })
//                    User.sharedCompanies.asObservable().subscribe({ (dict) in
//                        print(dict.element)
//                    })
                }else if let company = user as? Company {
                    
//                    User.sharedPosts.asObservable().subscribe({ (dict) in
//                        print(dict.element)
//                    })
                    
//                    User.sharedStudents.asObservable().subscribe({ (dict) in
//                        print(User.sharedStudents.value)
//                    })
                    
//                    let post = Post(title: "Sr. Android Developer Requried", description: "We need crazy developer", salary: "75,000", technology: "Android")
                    
//                    CompanyServices.updatePost(cID: company.cID!, post: post, completion: { (error) in
//                        if error != nil {
//                        
//                        }else {
//                        
//                        }
//                    })
                    
//                    CompanyServices.createPost(cID: company.cID!, post: post, completion: { (error) in
//                        
//                        if error != nil {
//                            
//                        }else {
//                            
//                            
//                        }
//                    })
                }
            }else {
                
            }
        }
        
       // self.validator.validate(self)
        
    }

    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        

        //Auth.login(email: "c@pc.com", password: "123456", completion: <#T##(String?) -> Void#>)
//        FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
//           
//            self.view.hideHud()
//            
//            guard let _ = user else {
//                self.showAlert(title: "Error", msg: error!.localizedDescription)
//                return
//            }
//            
//            let mainController = self.storyboard?.instantiateViewController(withIdentifier: "drawerController")
//            self.present(mainController!, animated: true, completion: nil)
//        })
        
        
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
