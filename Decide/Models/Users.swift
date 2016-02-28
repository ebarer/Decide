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
    
    func saveUser() -> Bool {
        let manager = DatabaseTransportManager()
        let object = self.toDict()
        
        let request = manager.postRequest(withParams: object, urlString: "login/create")
        if request.success {
            self.pk_uid = request.response?.valueForKey("pk_uid") as? Int
            defaults.setValue(self.pk_uid, forKey: "pk_uid")
            defaults.synchronize()
            return true
        }
    
        return false
    }
    
    // Send data, retrieve pk_uid
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
    
    // Send pk_uid, retrieve data
//    class func getUser(pk_uid: Int) -> User {
//        
//    }
    
    func getFriends() -> [User]? {
        return nil
    }
    
}

class Elliot: User {
    override func saveUser() -> Bool {
        return false
    }
}
