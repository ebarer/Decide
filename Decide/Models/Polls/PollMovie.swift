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
    
    convenience init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class ViewWhereWeUseLocationStuff: CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    
    func weAreInTheViewNow(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //Keep this optional check, optional will have nil at first call otherwise and will throw error
        if let latitude = locationManager.location?.coordinate.latitude {
            //send lat and long to a movie poll
        }
    }
    
}