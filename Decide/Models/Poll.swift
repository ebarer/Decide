//
//  Poll.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit
import CoreLocation

class Poll: NSObject {
    
    var pk_uid: Int?
    var title: String?
    var isEnded: Bool = false
    var options = [Option]()
    
    var admin:User?
    var users = [User]()
    
    var winningOption: Option? {
        if options.count > 0 {
            var winningOption = options.first
            
            for option in options {
                if option.votes.count > winningOption?.votes.count {
                    winningOption = option
                }
                
                return winningOption
            }
        }
        
        return nil
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    func savePoll() -> Bool {
        let manager = DatabaseTransportManager()
        let object = self.toDict()
        
        let request = manager.postRequest(withParams: object, urlString: "poll/create")
        if request.success {
            self.pk_uid = request.response?.valueForKey("pk_uid") as? Int
            return true
        }
        
        return false
    }
    
    func toDict() -> [String: String] {
        var dict:[String: String] = ["isEnded": String(isEnded)]
        
        if let title = title {
            dict["title"] = title
        }

        // Add admin
        if let uid = currentUser?.pk_uid {
            dict["admin"] = String(uid)
        }
        
        // Add users
        var usersUID = [String]()
        for user in users {
            if let uid = user.pk_uid {
                usersUID.append("{\"id\": \(String(uid))}")
            }
        }
        
        if usersUID.count > 0 {
            dict["users"] = "[\(usersUID.joinWithSeparator(","))]"
        }
        
        // Add options
        var optionDicts = [String]()
        
        for option in options {
            do {
                let json = try NSJSONSerialization.dataWithJSONObject(option.toDict(), options: [])
                let jsonString = NSString(data: json, encoding: NSASCIIStringEncoding)!
                optionDicts.append(String(jsonString))
            } catch {
                print("Issue serializing poll: \(self.title)")
                continue
            }
        }
        
        if optionDicts.count > 0 {
            dict["options"] = "[\(optionDicts.joinWithSeparator(","))]"
        }

        return dict
    }
    
    func closePoll() {
        self.isEnded = true
    }
    
    func addOption(newOption: Option) {
        self.options.append(newOption)
    }
    
    func removeOption(option: Option) {
        self.options.removeObject(option)
    }

}

func returnObjectNames(object: AnyObject) -> [String] {
    var names = [String]()
    
    if object.isKindOfClass(Poll) {
        for user in (object as! Poll).users {
            names.append(user.firstName)
        }
    } else if object.isKindOfClass(Option) {
        for user in (object as! Option).votes.users {
            names.append(user.firstName)
        }
    }
    
    return names
}