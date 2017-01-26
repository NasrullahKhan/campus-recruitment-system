//
//  RequestsServices.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class RequestsServices {
    
    static func applyPost(cID: String, postID: String, userID: String, completion : @escaping (_ errorDesc : String?) -> Void){
        
        let multiPath: [String: Any] = ["users-companies-requests/\(userID)/\(cID)/\(postID)": kFirebaseServerValueTimestamp, "companies-requests-by-users/\(cID)/\(postID)/\(userID)": kFirebaseServerValueTimestamp]
        
        cRef.updateChildValues(multiPath, withCompletionBlock: { (error, ref) in
            if error != nil {
                completion(error!.localizedDescription)
            }else {
                completion(nil)
            }
        })
    }
    
    static func userCompanyRequests(cID: String, postID: String, userID: String, completion : @escaping (_ errorDesc : String?) -> Void){
        
        cRef.child("users-companies-requests/\(userID)/\(cID)/\(postID)").observe(.value, with: { (userRequest) in
            completion(nil)
        })
    }
    
    static func companyUserRequests(cID: String, postID: String, completion : @escaping (_ errorDesc : String?) -> Void){
        
        cRef.child("companies-requests-by-users/\(cID)/\(postID)").observe(.childAdded, with: { (userIDs) in
            
            User.sharedCompanyRequestIDs.value.append(userIDs.key)
            
            completion(nil)
        })
    }
   
}
