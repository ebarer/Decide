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
    var title: String
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
    
    init(title: String) {
        self.title = title
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