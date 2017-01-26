//
//  Post.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation 

enum technology:Int {
    case iOS
    case android
    case web
}

class Post {

    var title: String?
    var description: String?
    var salary: String?
    var technology: technology?
    
    init(title: String, description: String, salary: String, technology: technology) {
        self.title = title
        self.description = description
        self.salary = salary
        self.technology = technology
    }
    

}
