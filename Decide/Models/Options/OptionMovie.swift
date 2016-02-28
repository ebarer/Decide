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

    var imdbRating: Float?
    var length: String?
    var genre: String?
    //var times: [NSDate]?
    var locationsAndTimes: [(theater:String, times:[String])]?
    var plot: String?
    var poster: String?
    var movieRating: String?
    var trailer: String?

    convenience init(title: String, imdbRating: Float, length: String, genre: String,
        locationsAndTimes: [(theater:String,times:[String])], plot: String, poster: String, movieRating: String, trailer: String) {
        self.init(title: title)
        
        self.imdbRating = imdbRating
        self.length = length
        self.genre = genre
        //self.times = times
        self.locationsAndTimes = locationsAndTimes
        self.plot = plot
        self.poster = poster
        self.movieRating = movieRating
        self.trailer = trailer
    }
    
//    func scrapeMoviesNearMe() {
//        // q = query (search, ie for movie)
//        // lat = latitude
//        // long = longitude
//
//        let lat = 49.5
//        let long = 123.2
//        
//        let html: String?
//        do {
//            html = try String(contentsOfURL: NSURL(string: "http://www.google.com/movies?lat=" + String(lat) + "&long=" + String(long))!, encoding: NSASCIIStringEncoding)
//        } catch _ {
//            html = nil
//        }
//        print(html)
//        print("http://www.google.com/movies?lat=" + String(lat) + "&long=" + String(long))
//        
//        // NOW PARSE IT
//        var html_parse = html!.componentsSeparatedByString("<div class=theater>")
//        html_parse.removeAtIndex(0) // doesnt have movie info
//        for theater in html_parse{
//            if theater.rangeOfString("<span class=closure>") != nil {
//                // theater hase no showtimes. remove from array
//                html_parse.removeObject(theater)
//            }
//            else{
//                // Retrieve Theater Name
//                //PASS
//                
//                //For temp, find Scotiabank Theatre Vancouver
//                if theater.rangeOfString("Scotiabank Theatre Vancouver") != nil{
//                    // seperate movie info
//                    var movies = theater.componentsSeparatedByString("<div class=movie>")
//                    let theaterinfo = movies.removeAtIndex(0)
//                    for movie in movies{
//                        var title = movie.componentsSeparatedByString("<span class=info>")[0]
//                        title = (title.componentsSeparatedByString(">")[2]).componentsSeparatedByString("<")[0]
//                        print(title)
//                        let info = (movie.componentsSeparatedByString("<span class=info>")[1]).componentsSeparatedByString("<a href")[0]
//                        let length = info.componentsSeparatedByString(" -")[0]
//                        print(length)
//                        if info.rangeOfString("Rated") != nil{
//                            let rated = (info.componentsSeparatedByString("Rated ")[1]).componentsSeparatedByString(" -")[0]
//                            print(rated)
//                        }
//                        var times = (movie.componentsSeparatedByString("<div class=times>")[1]).componentsSeparatedByString("-->")
//                        times.removeAtIndex(0)
//                        var timearray: [String] = []
//                        for time in times{
//                            timearray.append(time.componentsSeparatedByString("</span>")[0])
//                            print(time.componentsSeparatedByString("</span>")[0])
//                        }
//                    }
//                }
//            }
//        }
//        
//    }
    
    func getMovieInfo() {
        // omdb URL Parameters:
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
        
        if let url = NSURL(string: "http://www.omdbapi.com/?t=" + self.title + "&type=movie&plot=short&r=json&tomatoes=true") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
                if let data = data {
                    //print(NSString(data: data, encoding: NSUTF8StringEncoding))
                    do {
                        let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options:[])
                        //print("Array: \(jsonArray)")
                        self.imdbRating = Float(jsonArray["imdbRating"] as! String)
                        self.length = (jsonArray["Runtime"] as! String)
                        self.genre = (jsonArray["Plot"] as! String)
                        self.plot = (jsonArray["Plot"] as! String)
                        self.poster = (jsonArray["Poster"] as! String)
                    } catch {
                        print("Error: \(error)")
                    }
                
                } else {
                    print("\(response) - \(error)")
                }
            }
        
            task.resume()
        }
    }
}
