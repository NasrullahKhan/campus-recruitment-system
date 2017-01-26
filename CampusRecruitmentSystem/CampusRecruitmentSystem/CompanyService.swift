//
//  CompanyService.swift
//  CampusRecruitmentSystem
//
//  Created by Nasrullah Khan on 26/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class CompanyServices {

    static func createPost(cID: String, post: Post, completion : @escaping (_ errorDesc : String?) -> Void) {
        
        let postID = cRef.childByAutoId().key
        
        let post: [String: Any] = ["title": post.title!,"description": post.description!,"salary": post.salary!,"technology": post.technology!]
        
        let multiPath: [String: Any] = ["companies-posts/\(cID)/\(postID)": post, "companies/\(User.shared.value!.uID!)/\(cID)/postID/\(postID)": kFirebaseServerValueTimestamp]
        
        cRef.updateChildValues(multiPath) { (error, reference) in
            
            if error != nil {
                completion(error!.localizedDescription)
            }else {
                completion(nil)
            }
        }
    
    }
    
    static func updatePost(cID: String, post: Post, completion : @escaping (_ errorDesc : String?) -> Void) {
        
        let postID = "-KbPERWoXqD0PNs_CO7I"
        
        let post: [String: Any] = ["title": post.title!,"description": post.description!,"salary": post.salary!,"technology": post.technology!]
        
        let multiPath: [String: Any] = ["companies-posts/\(cID)/\(postID)": post, "companies/\(User.shared.value!.uID!)/\(cID)/postID/\(postID)": kFirebaseServerValueTimestamp]
        
        cRef.updateChildValues(multiPath) { (error, reference) in
            
            if error != nil {
                completion(error!.localizedDescription)
            }else {
                completion(nil)
            }
        }
        
    }
    
    static func listnerForCompanyPosts(cID: String){
       
        cRef.child("companies-posts/\(cID)").observe(.childAdded, with: { (post) in
            
            let data = post.value as! [String:Any]
            let postObj = Post(JSON: data)
            postObj!.postID = post.key
            
            User.sharedPosts.value = [post.key : postObj!]
        })
    }
    
    static func listnerForCompanies(){
        _ = rxGetOwners()
            .flatMap({ (user) -> Observable<Company> in
                return rxGetCompanies(user:user)
            })
            .subscribe { (company) in
                User.sharedCompanies.value = [company.element!.cID! : company.element!]
        }
    }
    
    static func rxGetOwners()->Observable<User>{
        
        return Observable.create { observer in
            cRef.child("users").queryOrdered(byChild: "userType").queryEqual(toValue: 2).observe(.childAdded, with: { (owner) in
                let ownerObj = Mapper<User>().map(JSONObject: owner.value!)
                ownerObj!.uID = owner.key
                observer.onNext(ownerObj!)
            })
            return Disposables.create {}
        }
    }
    
    static func rxGetCompanies(user:User)->Observable<Company>{
        return Observable.create { observer in
            cRef.child("companies/\(user.uID!)").observe(.childAdded, with: { (company) in
                let companyObj = user + Mapper<Company>().map(JSONObject: company.value!)!
                companyObj.cID = company.key
                observer.onNext(companyObj)
            })
            return Disposables.create {}
        }
    }

    

    
}
