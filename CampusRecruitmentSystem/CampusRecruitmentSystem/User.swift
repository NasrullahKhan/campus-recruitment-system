//
//  Model.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import ObjectMapper

class User:Mappable {
    
    var email: String?
    var name: String?
    var contactNo: Int?
    var userType: Int?
    var password: String?
    
    init(email: String, name: String, contactNo: Int, userType: Int, password: String) {
        self.email = email
        self.name = name
        self.contactNo = contactNo
        self.userType = userType
        self.password = password
    }
    
    // Mappable
    func mapping(map: Map) {
        email           <- map["email"]
        name     <- map["name"]
        contactNo        <- map["contactNo"]
        userType          <- map["userType"]
        password       <- map["password"]
    }
    
    required init(map: Map) {
        
    }

    
}

