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
    var email: String
    var fb_id: String
    var profilePicture: NSURL?
    
    init(withFirstName firstName: String, lastName: String, email: String, fb_id: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.fb_id = fb_id
    }
    
    func saveUser() -> Bool {
        let manager = DatabaseTransportManager()
        let object = self.toDict()
        
        let request = manager.postRequest(withParams: object, urlString: "https://dwfnwhacks2016.herokuapp.com/login/create")
        if request.success {
            self.pk_uid = request.response?.valueForKey("pk_uid") as? Int
            defaults.setValue(self.pk_uid, forKey: "pk_uid")
            defaults.synchronize()
            return true
        }
    
        return false
    }
    
    class func getUser(pk_uid: Int) -> User {
        // Send to backend UID
        
        // Backend sends JSON
        
        // Create User
        return User(withFirstName: "Elliot", lastName: "Barer", email: "ebarer@mac.com", fb_id: String(1001))
    }
    
    func toDict() -> [String: String] {
        return ["first_name": firstName, "last_name": lastName, "email": email, "fb_id": String(fb_id)]
    }
    
    func getFriends() -> [User]? {
        return nil
    }
    
}

