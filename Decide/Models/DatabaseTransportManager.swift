//
//  DatabaseTransportManager.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import Foundation

class DatabaseTransportManager: NSObject {

    func postRequest(withParams params: [String: String], urlString: String, handler:(response: AnyObject?) -> Void) {
        do {
            let url: NSURL = NSURL(string: "https://dwfnwhacks2016.herokuapp.com/\(urlString)")!
            let request = NSMutableURLRequest(URL: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.HTTPMethod = "POST"
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
            let theJSONText = NSString(data: request.HTTPBody!, encoding: NSASCIIStringEncoding)
            print("JSON Output: \(theJSONText!)")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do {
                    if error == nil {
                        if let data = data {
                            let responseJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
                            handler(response: responseJSON)
                        }
                    } else {
                        handler(response: nil)
                    }
                } catch let error as DTMError {
                    print(error.rawValue)
                } catch {
                    print(error)
                }
            }.resume()
        } catch {
            print(error)
        }
    }
}

enum DTMError: String, ErrorType {
    case NoData = "-E- DTM: No data"
    case JSONConversionFailed = "-E- DTM: Conversion from JSON failed"
}