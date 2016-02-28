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
<<<<<<< HEAD
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
=======
    var isEnded: Bool = false
    var options = [Option]()
    
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
    
    
>>>>>>> master
}