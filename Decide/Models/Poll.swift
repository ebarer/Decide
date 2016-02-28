//
//  Poll.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit
import CoreLocation

class Poll:NSObject {
    let pk_uid: Int
    var title: String
    var optionIds = [Int]()
    var winningOptionId: Int
    var isEnded: Bool = false
    var theme: PollType
    var latitude: Double
    var longitude: Double
    
    init(withUID uid: Int, title: String, optionIds: [Int], winningOptionId: Int, isEnded: Bool = false, theme: PollType, latitude: Double, longitude: Double) {
        self.pk_uid = uid
        self.title = title
        self.optionIds = optionIds
        self.winningOptionId = winningOptionId
        self.isEnded = isEnded
        self.theme = theme
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func populateNearbyMovies() {
        print(self.theme)
        print(self.latitude)
        print(self.longitude)
    }
    
}

//MARK: - PollType Enum
enum PollType {
    case General
    case Movie
    case Restaurant

    var description: String {
        switch self {
        case .General: return "General"
        case .Movie: return "Movie"
        case .Restaurant: return "Restaurant"
        }
    }
}