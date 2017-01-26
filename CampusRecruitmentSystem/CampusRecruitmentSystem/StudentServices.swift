//
//  UserServices.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class StudentServices {
    
    static func listnerForStudent(){
        _ = rxStudents()
            .flatMap({ (user) -> Observable<Student> in
                return rxStudentsAcedemics(user:user)
            })
            .subscribe { (user) in
                User.sharedStudents.value[user.element!.uID!] =  user.element!
        }
    }
    
    static func rxStudents()->Observable<User>{
        
        return Observable.create { observer in
            cRef.child("users").queryOrdered(byChild: "userType").queryEqual(toValue: 0).observe(.childAdded, with: { (student) in
                let stu = Mapper<User>().map(JSONObject: student.value!)
                stu!.uID = student.key
                observer.onNext(stu!)
            })
            return Disposables.create {}
        }
    }
    
    static func rxStudentsAcedemics(user:User)->Observable<Student>{
        return Observable.create { observer in
            cRef.child("academics/\(user.uID!)").observe(.value, with: { (data) in
                let stu = user + Mapper<Student>().map(JSONObject: data.value!)!
                observer.onNext(stu)
            })
            return Disposables.create {}
        }
    }
}
