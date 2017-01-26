//
//  StudentsViewController.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit
import RxSwift

class StudentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    var students = [String: Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Students"
        
        _ = User.sharedStudents.asObservable()
            .subscribe { (studentDict) in

                self.students = User.sharedStudents.value
                self.tableView.reloadData()
                
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCellIdentifier", for: indexPath) as! StudentCell
        
        let student = Array(self.students.values)[indexPath.row]
        cell.name.text = student.name
        cell.cgpa.text = student.cgpa
        cell.year.text = student.year
        cell.rollNo.text = student.rollNo
        
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
