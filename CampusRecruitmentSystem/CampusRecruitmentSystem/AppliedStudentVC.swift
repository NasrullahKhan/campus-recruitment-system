//
//  AppliedStudentVC.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit
import RxSwift

class AppliedStudentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var studentsRequest = [String: Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "AppliedStudent"
       
        User.sharedCompanyRequestIDs.asObservable()
            .subscribe { (userID) in
               
                for userID in User.sharedCompanyRequestIDs.value {
                
                    if let student = User.sharedStudents.value[userID] {
                        self.studentsRequest[userID] = student
                    }
                }
                
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentsRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appliedStudentCellIdentifier", for: indexPath) as! AppliedStudentCell
        
        let student = Array(self.studentsRequest.values)[indexPath.row]
        cell.studentName.text = student.name
        cell.cgpa.text = student.cgpa
        cell.year.text = student.year
        
        return cell
    }


}
