//
//  CreatePostViewController.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postDescription: UITextField!
    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var technology: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createTapped(_ sender: Any) {
        
        self.view.showHud()
        
        let post = Post(title: self.postTitle.text!, description: self.postDescription.text!, salary: self.salary.text!, technology: self.technology.text!)
        
        let company = User.shared.value as? Company
        
        CompanyServices.createPost(cID: company!.cID!, post: post, completion: { (error) in
            
            self.view.hideHud()
            
            if error != nil {
                self.showAlert(title: "Error", msg: error!)
            }else {
                
                self.showAlert(title: "Success", msg: "Post Created Successfully", okClick: { 
                    self.navigationController!.popViewController(animated: true)
                })
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
