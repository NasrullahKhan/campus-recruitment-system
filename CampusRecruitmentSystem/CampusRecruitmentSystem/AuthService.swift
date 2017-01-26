//
//  Auth.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class Auth {
    
    static func createStudent(student: Student, completion : @escaping (_ errorDesc : String?) -> Void) {
        
        FIRAuth.auth()?.createUser(withEmail: student.email!, password: student.password!, completion: { (user, error) in
            
            guard let _ = user else {
                completion(error!.localizedDescription)
                return
            }
            
            let userEntry: [String: Any] = ["email": student.email!, "name": student.name!, "contactNo": student.contactNo!, "userType": 0]
            
            let academicEntry: [String: Any] = ["cgpa": student.cgpa!, "year": student.year!, "course": student.course!, "rollNo": student.rollNo!]
            
            let multiPath: [String: Any] = ["users/\(user!.uid)": userEntry, "academics/\(user!.uid)": academicEntry]
            
            cRef.updateChildValues(multiPath, withCompletionBlock: { (error, ref) in
                if error != nil {
                    completion(error!.localizedDescription)
                }else {
                    
                    User.shared.value = student
                    completion(nil)
                }
            })
            
        })
    }
    
    static func createCompany(company: Company, completion : @escaping (_ errorDesc : String?) -> Void) {
        
        FIRAuth.auth()?.createUser(withEmail: company.email!, password: company.password!, completion: { (user, error) in
            
            guard let _ = user else {
                completion(error!.localizedDescription)
                return
            }
            
            let userEntry: [String: Any] = ["email": company.email!, "name": company.name!, "contactNo": company.contactNo!, "userType": 2]
            
            let companyEntry: [String: Any] = ["address": company.address!, "companyName": company.companyName!, "description": company.description!]
            
            let multiPath: [String: Any] = ["users/\(user!.uid)": userEntry, "companies/\(user!.uid)/\(cRef.childByAutoId().key)": companyEntry]
            
            cRef.updateChildValues(multiPath, withCompletionBlock: { (error, ref) in
                if error != nil {
                    completion(error!.localizedDescription)
                }else {
                    User.shared.value = company
                    completion(nil)
                }
            })
            
        })
    }
    
    static func login(email: String, password: String, completion : @escaping (_ user: User? ,_ errorDesc : String?) -> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            guard let _ = user else {
                completion(nil, error!.localizedDescription)
                return
            }
            
            cRef.child("users/\(user!.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let data = snapshot.value as! [String:Any]
                let userObj = User(JSON: data)
                userObj!.uID = user!.uid
                
                switch userObj!.userType! {
                case .student:
                    cRef.child("academics/\(user!.uid)").observeSingleEvent(of: .value, with: { (academicsData) in
                        let academicData = academicsData.value as! [String:Any]
                        let stuObj = Student(JSON: academicData)
                        let student = userObj! + stuObj!
                        User.shared.value = student
                        CompanyServices.listnerForCompanies()
                        completion(student, nil)
                    })
                case .admin:
                    break
                    
                case .company:
                    
                    cRef.child("companies/\(user!.uid)").observeSingleEvent(of: .childAdded, with: { (companyData) in
                        
                        let data = companyData.value as! [String:Any]
                        let companyObj = Company(JSON: data)
                        companyObj!.cID = companyData.key
                        let company = userObj! + companyObj!
                        User.shared.value = company
                        StudentServices.listnerForStudent()
                        CompanyServices.listnerForCompanyPosts(cID: companyData.key)
                        completion(company, nil)
                    })
                }
                
                })
                
            })
            
            
        }
}
