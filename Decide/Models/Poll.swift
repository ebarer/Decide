//
//  Poll.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class Poll:NSObject {
    let pk_uid: Int
    var title: String
    var optionIds = [Int]()
    var winningOptionId: Int
    var isEnded: Bool
    
    init(withUID uid: Int, title: String, optionIds: [Int], winningOptionId: Int, isEnded: Bool) {
        self.pk_uid = uid
        self.title = title
        self.optionIds = optionIds
        self.winningOptionId = winningOptionId
        self.isEnded = isEnded
    }
    
}