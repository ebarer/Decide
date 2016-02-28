//
//  Option.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class Option:NSObject {
    let pk_uid: Int
    let fk_uid: Int
    var title: String
    var votes: (count: Int, users:[User]) = (0, []) //Elliot: handle case for count<0
    
    init(withUID uid: Int, fk_uid: Int, title: String) {
        self.pk_uid = uid
        self.fk_uid = fk_uid
        self.title = title
    }
    
    func voteFor(voter: User) {
        votes.count += 1
        votes.users.append(voter)
    }
    
    func unvoteFor(voter: User) {
        votes.count -= 1
        votes.users.removeObject(voter)
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