//
//  Company.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import ObjectMapper

class Company: User {
    
    var address: String?
    var companyName: String?
    var description: String?
    var cID: String?
    
    init(address: String, companyName: String, description: String, email: String, name: String, contactNo: Int, userType: UserType, password: String) {
        self.address = address
        self.companyName = companyName
        self.description = description
        super.init(email: email, name: name, contactNo: contactNo, userType: userType, password: password)
    }
    
    required init(map: Map) {
        super.init(map: map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        self.address         <- map["address"]
        self.companyName     <- map["companyName"]
        self.description     <- map["description"]
    }
}


