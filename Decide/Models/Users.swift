//
//  Users.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class User:NSObject {
    let pk_uid: Int
    var firstName: String
    var lastName: String
    var email: String
    var fb_id: Int?
    var profilePicture: NSURL?
    
    init(withUID uid: Int, firstName: String, lastName: String, email: String) {
        self.pk_uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    func getFriends() -> [User]? {
        return nil
    }
    
}

