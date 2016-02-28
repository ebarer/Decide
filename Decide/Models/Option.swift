//
//  Option.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class Option: NSObject {
    
    var pk_uid: Int?
    var fk_uid: Int?
    var title: String
    var votes: (count: Int, users:[User]) = (0, []) //Elliot: handle case for count<0
    
    init(title: String) {
        self.title = title
    }
    
    func updateOption() {
        DatabaseTransportManager().postRequest(withParams: self.toDict(), urlString: "option/update") { (response) in
            print(response)
        }
    }
    
    func toDict() -> [String: String] {
        var dict:[String: String] = ["title": title, "count": String(votes.count)]
        
        // Save changes
        var usersUID = [String]()
        for user in votes.users {
            usersUID.append("{\"id\": \(user.fb_id)}")
        }
        
        if usersUID.count > 0 {
            dict["users"] = "[\(usersUID.joinWithSeparator(","))]"
        }

        return dict
    }
    
    
    // MARK: - Behaviours
    
    func voteFor(withVoter voter: User) {
        if votes.users.contains(voter) == false {
            votes.count += 1
            votes.users.append(voter)
        }
    }
    
    func unvoteFor(withVoter voter: User) {
        if votes.users.contains(voter) == true {
            votes.count -= 1
            votes.users.removeObject(voter)
        }
    }


}

// MARK: - Array extension
extension Array {
    mutating func removeObject<U: Equatable>(object: U) {
        for (index, compare) in self.enumerate() {
            if let compare = compare as? U {
                if object == compare {
                    self.removeAtIndex(index)
                    break
                }
            }
        }
    }
}