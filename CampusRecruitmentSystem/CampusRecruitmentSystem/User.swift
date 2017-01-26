//
//  Model.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

class User:Mappable {
    
    var email: String?
    var name: String?
    var contactNo: String?
    var userType: UserType?
    var password: String?
    var uID: String?
    
    static var shared: Variable<User?> = Variable<User?>(nil)
    static var sharedStudents: Variable<[String:Student]> = Variable([:])
    static var sharedPosts: Variable<[String: [String:Post]]> = Variable([:])
    static var sharedCompanies: Variable<[String:Company]> = Variable([:])
    
    init(email: String, name: String, contactNo: String, userType: UserType, password: String) {
        self.email = email
        self.name = name
        self.contactNo = contactNo
        self.userType = userType
        self.password = password
    }
    
    // Mappable
    func mapping(map: Map) {
        email           <- map["email"]
        name            <- map["name"]
        contactNo       <- map["contactNo"]
        userType        <- (map["userType"], transformIntoUserType)
        password        <- map["password"]
    }
    
    required init(map: Map) {
        
    }

}

func +(user: User, student: Student) -> Student {
    
    student.email = user.email!
    student.name = user.name!
    student.contactNo = user.contactNo!
    student.userType = user.userType!
    student.uID = user.uID!
    
    return student
}

func +(user: User, company: Company) -> Company {
    
    company.email = user.email
    company.name = user.name
    company.contactNo = user.contactNo
    company.userType = user.userType
    company.uID = user.uID
    
    return company
}

