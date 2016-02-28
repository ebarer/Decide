//
//  OptionRestaurant.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class Restaurant: Option {
    var cuisine: String?
    var address: String?
    var hours: (opening: Int?, closing: Int?)
    var yelpRating: Float?
    var imageURL: String?
    
    convenience init(withUID uid: Int, fk_uid: Int, title: String, cuisine: String, address: String, hours: (Int, Int), yelpRating: Float, imageURL: String) {
        self.init(withUID: uid, fk_uid: fk_uid, title: title)
        
        self.cuisine = cuisine
        self.address = address
        
        self.hours.opening = hours.0
        self.hours.closing = hours.0
        
        self.yelpRating = yelpRating
        self.imageURL = imageURL
    }
}