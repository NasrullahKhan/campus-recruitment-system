//
//  StudentMainVC.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit

class StudentMainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var companies = [String: Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Companies"
        
        _ = User.sharedCompanies.asObservable().subscribe { (company) in
            for company in User.sharedCompanies.value {
                self.companies[company.key] = company.value
            }
            self.tableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCellIdentifier", for: indexPath) as! CompanyCell
        
        let company = Array(self.companies.values)[indexPath.row]
        cell.companyTitle.text = company.companyName
        cell.address.text = company.address
        cell.desc.text = company.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let company = Array(self.companies.values)[indexPath.row]
        self.performSegue(withIdentifier: "goToPostVC", sender: company)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let company = sender as? Company{
            let dest = segue.destination as! PostTableViewController
            dest.selectedCompanyID = company.cID!
        }
        
    }
    
}
