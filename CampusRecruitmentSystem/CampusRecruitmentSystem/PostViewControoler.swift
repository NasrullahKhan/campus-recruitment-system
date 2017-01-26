//
//  PostViewControoler.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit

class PostViewControoler: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
     var posts = [String: Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Posts"
        
        self.tabBarController!.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.goToCreatePost)), animated: true)
        
        let company = User.shared.value as? Company
        
        User.sharedPosts.asObservable()
            .subscribe { (postDic) in
                
                if let _ = postDic.element![company!.cID!] {
                    self.posts = postDic.element![company!.cID!]!
                    self.tableView.reloadData()
                }
                
        }
        
        // Do any additional setup after loading the view.
    }

    func goToCreatePost(){
        
        self.performSegue(withIdentifier: "goToCreatePost", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyPostCellIdentifier", for: indexPath) as! CompanyPostCell
        
        let post = Array(self.posts.values)[indexPath.row]
        cell.postTitle.text = post.title
        cell.salary.text = post.salary
        cell.desc.text = post.description
        
        return cell
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
