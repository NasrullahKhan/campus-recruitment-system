//
//  PostTableViewController.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit
import RxSwift

class PostTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedCompanyID: String?
    var posts = [String: Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CompanyServices.listnerForCompanyPosts(cID: selectedCompanyID!)
        
        User.sharedPosts.asObservable()
            .subscribe { (postDic) in
            
                if let _ = postDic.element![self.selectedCompanyID!] {
                    self.posts = postDic.element![self.selectedCompanyID!]!
                    self.tableView.reloadData()
                }
                
        }
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCellIdentifier", for: indexPath) as! PostCell
        
        let post = Array(self.posts.values)[indexPath.row]
        cell.postTitle.text = post.title
        cell.salary.text = post.salary
        cell.desc.text = post.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = Array(self.posts.values)[indexPath.row]
        self.view.showHud()
        
        RequestsServices.applyPost(cID: self.selectedCompanyID!, postID: post.postID!, userID: User.shared.value!.uID!) { (error) in
            
            self.view.hideHud()
            
            if error != nil {
                self.showAlert(title: "Error", msg: error!)
            }else {
                self.showAlert(title: "Success", msg: "Applied Successfully")
                
            }
        }
        
    }

}
