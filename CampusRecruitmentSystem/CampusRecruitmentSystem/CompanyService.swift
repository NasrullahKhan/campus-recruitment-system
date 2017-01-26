//
//  CompanyService.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation

class CompanyServices {

    static func createPost(cID: String, post: Post, completion : @escaping (_ errorDesc : String?) -> Void) {
        
        let postID = cRef.childByAutoId().key
        
        let post: [String: Any] = ["title": post.title!,"description": post.description!,"salary": post.salary!,"technology": post.technology!.rawValue]
        
        let multiPath: [String: Any] = ["companies-posts/\(cID)/\(postID)": post, "companies/\(User.shared.value!.uID!)/\(cID)/postID/\(postID)": kFirebaseServerValueTimestamp]
        
        cRef.updateChildValues(multiPath) { (error, reference) in
            
            if error != nil {
                completion(error!.localizedDescription)
            }else {
                completion(nil)
            }
        }
    
    }
}
