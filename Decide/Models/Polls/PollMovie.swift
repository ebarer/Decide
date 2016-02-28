//
//  PollMovie.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit
import CoreLocation

class MoviePoll: Poll {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var movieOptions = [Movie]()
    
    convenience init(title: String, latitude: Double, longitude: Double, movieOptions:[Movie]) {
        self.init(title: title)
        self.latitude = latitude
        self.longitude = longitude
        self.movieOptions = movieOptions
    }
    
    override func addOption(newOption: Option) {
        self.movieOptions.append(newOption as! Movie)
    }
}

    // MARK: - Facebook Methods

//We will need to port the below class to the view controller class that we will
//need location data for

//class ViewWhereWeUseLocationStuff: CLLocationManagerDelegate {
//    var locationManager: CLLocationManager!
//    
//    func weAreInTheViewNow(){
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//        
//        //Keep this optional check, optional will have nil at first call otherwise and will throw error
//        if let latitude = locationManager.location?.coordinate.latitude {
//            //send lat and long to a movie poll
//        }
//    }
//    
//}