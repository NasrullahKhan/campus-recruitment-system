//
//  UserType.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import ObjectMapper

enum UserType:Int{
    case student,admin,company
}

let transformIntoUserType = TransformOf<UserType, Int>(fromJSON: { (value: Int?) -> UserType? in
    // transform value from String? to Int?
    return UserType(rawValue: value!)
}, toJSON: { (value: UserType?) -> Int? in
    // transform value from Int? to String?
    if let value = value {
        return value.rawValue
        
    }
    return nil
})
