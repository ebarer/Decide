//
//  DatabaseTransportManager.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import Foundation

class DatabaseTransportManager: NSObject {

    func postRequest(withParams params: [String: String], urlString: String) -> (success: Bool, response: NSData?) {
        do {
            let url: NSURL = NSURL(string: urlString)!
            let request = NSMutableURLRequest(URL: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.HTTPMethod = "POST"
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
            let theJSONText = NSString(data: request.HTTPBody!,encoding: NSASCIIStringEncoding)
            print("JSON string = \(theJSONText!)")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do {
                    //print(response)
                    
                    if let data = data {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
                        print(json)
                        
                        dispatch_async(dispatch_get_main_queue(), {
//                            NSNotificationCenter.defaultCenter().postNotificationName("updateExchange", object: nil)
                            return (true, json)
                        })
                    }
                } catch let error as HTMLError {
                    print(error.rawValue)
                } catch {
                    print(error)
                }
            }.resume()
        } catch {
            print(error)
        }
        
        return (false, nil)
    }
}

enum DTMError: String, ErrorType {
    case NoData = "-E- DTM: No data"
    case JSONConversionFailed = "-E- DTM: Conversion from JSON failed"
}