//
//  Model.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    var email: String
    var fullName: String
    var CGPA: Float
    var rollNo: Int
    var mobileNumber: Int
    
    init(email: String, fullName: String, CGPA: Float, rollNo: Int, mobileNumber: Int) {
        self.email = email
        self.fullName = fullName
        self.CGPA = CGPA
        self.rollNo = rollNo
        self.mobileNumber = mobileNumber
    }
}

