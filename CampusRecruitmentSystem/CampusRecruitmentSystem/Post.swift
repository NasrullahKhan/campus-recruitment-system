//
//  Post.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import ObjectMapper

enum technology:Int {
    case iOS
    case android
    case web
}

class Post : Mappable {

    var title: String?
    var description: String?
    var salary: String?
    var technology: String?
    var postID: String?
    
    init(title: String, description: String, salary: String, technology: String) {
        self.title = title
        self.description = description
        self.salary = salary
        self.technology = technology
    }
    
    // Mappable
    func mapping(map: Map) {
        title           <- map["title"]
        description     <- map["description"]
        salary          <- map["salary"]
        technology      <- map["technology"]
    }
    
    required init(map: Map) {
        
    }
    

}
