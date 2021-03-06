//
//  Student.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import ObjectMapper

class Student: User {
    
    var rollNo: String?
    var year: String?
    var course: String?
    var cgpa: String?
    
    init(rollNo: String, year: String, course: String,cgpa: String, email: String, name: String, contactNo: String, userType: UserType, password: String) {
        self.rollNo = rollNo
        self.year = year
        self.course = course
        self.cgpa = cgpa
        super.init(email: email, name: name, contactNo: contactNo, userType: userType, password: password)
    }
    
    required init(map: Map) {
        super.init(map: map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        self.rollNo     <- map["rollNo"]
        self.year       <- map["year"]
        self.course     <- map["course"]
        self.cgpa       <- map["cgpa"]
    }
    
}
