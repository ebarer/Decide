//
//  Movie.swift
//  Decide With Friends
//
//  Created by Kahlan Gibson on 2/27/16.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import Foundation
import MapKit

class Movie: Option {
    // location and times from google,
    // others from imdb
    var rating: Float?
    var length: String?
    var genre: String?
    var times: [NSDate]?
    var location: String?
    var plot: String?
    var poster: String?
    
    convenience init(withUID uid: Int, fk_uid: Int, title: String, rating: Float, length: String, genre: String, times: [NSDate], location: String, plot: String, poster: String) {
        self.init(withUID: uid, fk_uid: fk_uid, title: title)
        
        self.rating = rating
        self.length = length
        self.genre = genre
        self.times = times
        self.location = location
        self.plot = plot
        self.poster = poster
    }
    
    func getMovieInfo() {
        // URL Parameters:
        // i = imdb id
        // t = movie title
        // type = {movie, series, episode} type of result
        // y = year of release
        // plot = {short, full} short or full plot
        // r = {json, xml} return data type
        // tomatoes = {true, false} bool to return rotten tomatoes ratings
        // callback = JSONP callback name
        // v = API version
        //let url: NSURL = NSURL(string: "http://www.omdbapi.com/?t=" + self.title + "&type=movie&plot=short&r=json&tomatoes=true")!
        //let request = NSMutableURLRequest(URL: url)
        
        let url = NSURL(string: "http://www.omdbapi.com/?t=" + self.title + "&type=movie&plot=short&r=json&tomatoes=true")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            if let data = data {
                //print(NSString(data: data, encoding: NSUTF8StringEncoding))
                do {
                    let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options:[])
                    //print("Array: \(jsonArray)")
                    self.rating = Float(jsonArray["imdbRating"] as! String)
                    self.length = (jsonArray["Runtime"] as! String)
                    self.genre = (jsonArray["Plot"] as! String)
                    self.plot = (jsonArray["Plot"] as! String)
                    self.poster = (jsonArray["Poster"] as! String)
                }
                catch {
                    print("Error: \(error)")
                }
                
            } else {
                print("\(response) - \(error)")
            }
        }
        
        task.resume()
    }
}

// MARK: - MovieGenre Enum
//enum MovieGenre {
//    case Action
//    case Comedy
//    case Horror
//    
//    var description: String {
//        switch self {
//        case .Action: return "Action"
//        case .Comedy: return "Comedy"
//        case .Horror: return "Horror"
//        }
//    }
//}