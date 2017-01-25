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
            
            let userEntry: [String: Any] = ["email": student.email!, "name": student.name!, "contactNo": student.contactNo!, "userType": student.userType!]
            
            let academicEntry: [String: Any] = ["cgpa": student.cgpa!, "year": student.year!, "course": student.course!, "rollNo": student.rollNo!]
            
            let multiPath: [String: Any] = ["users/\(user!.uid)": userEntry, "academics/\(user!.uid)": academicEntry]
            
            cRef.updateChildValues(multiPath, withCompletionBlock: { (error, ref) in
                if error != nil {
                    completion(error!.localizedDescription)
                }else {
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
            
            let userEntry: [String: Any] = ["email": company.email!, "name": company.name!, "contactNo": company.contactNo!, "userType": company.userType!]
            
            let companyEntry: [String: Any] = ["address": company.address!, "companyName": company.companyName!, "description": company.description!]
            
            let multiPath: [String: Any] = ["users/\(user!.uid)": userEntry, "company/\(user!.uid)": companyEntry]
            
            cRef.updateChildValues(multiPath, withCompletionBlock: { (error, ref) in
                if error != nil {
                    completion(error!.localizedDescription)
                }else {
                    completion(nil)
                }
            })
            
        })
    }
    
    static func login(email: String, password: String, completion : @escaping (_ errorDesc : String?) -> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            guard let _ = user else {
                completion(error!.localizedDescription)
                return
            }
            
            cRef.child("users/\(user!.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot)
                
                let data = snapshot.value as! [String:Any]
                let userObj = User(JSON: data)
                
                switch userObj!.userType! {
                case .student:
                    print(userObj)
                    cRef.child("academics/\(user!.uid)").observeSingleEvent(of: .value, with: { (academics) in
                        let data = snapshot.value as! [String:Any]
                        let studentObj = Student(JSON: data)
                        
                    })
                case .admin:
                    print(userObj)
                case .company:
                    print(userObj)
                    cRef.child("company/\(user!.uid)").observeSingleEvent(of: .value, with: { (academics) in
                        let data = snapshot.value as! [String:Any]
                        let companyObj = Company(JSON: data)
                        
                    })
                }
                    
                    
                    completion(nil)
                })
                
            })
            
            
        }
}
