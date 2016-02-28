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
    var rating: Float?
    var length: NSTimeInterval?
    var genre: MovieGenre?
    var times: [NSDate]?
    var location: String?
    
    convenience init(withUID uid: Int, fk_uid: Int, title: String, rating: Float, length: Double, genre: MovieGenre, times: [NSDate], location: String) {
        self.init(withUID: uid, fk_uid: fk_uid, title: title)
        
        self.rating = rating
        self.length = NSTimeInterval(length)
        self.genre = genre
        self.times = times
        self.location = location
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
        let url: NSURL = NSURL(string: "http://www.omdbapi.com/?t=")!
        let request = NSMutableURLRequest(URL: url)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let data = data else { throw HTMLError.NoData }
                guard let returnString = String(data: data, encoding: NSASCIIStringEncoding) else { throw HTMLError.ConversionFailed }
                let returnArray = returnString.characters.split{$0 == ","}.map(String.init)
                
                if returnArray.count > 1 {
                    // Update Movie values here
                    // self.rating, etc..
                } else {
                    throw HTMLError.ExchangeRateMissing
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    NSNotificationCenter.defaultCenter().postNotificationName("updateExchange", object: nil)
                })
            } catch let error as HTMLError {
                print(error.rawValue)
            } catch {
                print(error)
            }
            }.resume()
    }
}

// MARK: - MovieGenre Enum
enum MovieGenre {
    case Action
    case Comedy
    case Horror
    
    var description: String {
        switch self {
        case .Action: return "Action"
        case .Comedy: return "Comedy"
        case .Horror: return "Horror"
        }
    }
}

enum HTMLError: String, ErrorType {
    case NoData = "-E- No data"
    case ConversionFailed = "-E- Conversion from JSON failed"
    case ExchangeRateMissing = "-E- No exchange rate"
}