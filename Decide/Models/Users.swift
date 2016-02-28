//
//  Users.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var pk_uid: Int?
    var firstName: String
    var lastName: String
    var email: String?
    var fb_id: String
    var profilePicture: NSURL?
    var userPolls = [Poll]()
    
    init(withFirstName firstName: String, lastName: String, email: String?, fb_id: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.fb_id = fb_id
    }
    
    class func getUser(pk_uid: Int) {
        let object = ["pk_uid" : String(pk_uid)]
        DatabaseTransportManager().postRequest(withParams: object, urlString: "login/index") { (response) in
            print(response)
            if let response = response {
                if let _ = response.valueForKey("Error") {
                    // #DEBUG
                    defaults.setValue(nil, forKey: "pk_uid")
                    fatalError("Bad account")
                } else {
                    let firstName = response.valueForKey("first_name") as! String
                    let lastName = response.valueForKey("last_name") as! String
                    let email = response.valueForKey("email") as! String
                    let fbID = response.valueForKey("fb_id") as! Int
                    
                    currentUser = User(withFirstName: firstName, lastName: lastName, email: email, fb_id: String(fbID))
                    currentUser?.pk_uid = pk_uid
                }
            }
        }
    }
    
    func saveUser() {
        DatabaseTransportManager().postRequest(withParams: self.toDict(), urlString: "login/create") { (response) in
            print(response)
            if let id = response?.valueForKey("id") as? Int {
                self.pk_uid = id
                defaults.setValue(id, forKey: "pk_uid")
                defaults.synchronize()
            }
        }
    }
    
    func toDict() -> [String: String] {
        var dict = ["first_name": firstName, "last_name": lastName, "fb_id": fb_id]
        
        if let email = email {
            dict["email"] = email
        }
        
        if let pictureUrl = profilePicture {
            dict["profile_picture"] = String(pictureUrl)
        }
        
        var pollUID = [String]()
        for poll in polls {
            if let uid = poll.pk_uid {
                pollUID.append("{\"id\": \(String(uid))}")
            }
        }
        
        if pollUID.count > 0 {
            dict["polls"] = "[\(pollUID.joinWithSeparator(","))]"
        }

        return dict
    }
    
    func getFriends() -> [User]? {
        return nil
    }
    
}