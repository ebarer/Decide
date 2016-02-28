//
//  AddPollTVC_Options.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollTVC_Options_Movie: UITableViewController, UITextFieldDelegate {
    
    var newPoll: MoviePoll!
    
    @IBOutlet var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
        
        if newPoll.movieOptions.count > 1 {
            nextButton.enabled = false
        } else {
            nextButton.enabled = false
        }
        
        scrapeMoviesNearMe()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let addCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) {
            if addCell.isKindOfClass(AddPollTVC_Options_AddCell_Movie) {
                (addCell as! AddPollTVC_Options_AddCell_Movie).addOptionTextField.becomeFirstResponder()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Google Scrape Method
    func scrapeMoviesNearMe() {
        // lat = latitude
        // long = longitude
        
        let lat = 49.5
        let long = 123.2
        
        let html: String?
        do {
            html = try String(contentsOfURL: NSURL(string: "http://www.google.com/movies?lat=" + String(lat) + "&long=" + String(long))!, encoding: NSASCIIStringEncoding)
        } catch _ {
            html = nil
        }
        //print(html)
        print("http://www.google.com/movies?lat=" + String(lat) + "&long=" + String(long))
        
        // NOW PARSE IT
        var html_parse = html!.componentsSeparatedByString("<div class=theater>")
        html_parse.removeAtIndex(0) // doesnt have movie info
        for theater in html_parse{
            if theater.rangeOfString("<span class=closure>") != nil {
                // theater hase no showtimes. remove from array
                html_parse.removeObject(theater)
            }
            else{//theater has showtimes. Add to Array of movie objects
                
                // Retrieve Theater Name
                //PASS
                
                //For temp, find Scotiabank Theatre Vancouver
                if theater.rangeOfString("Scotiabank Theatre Vancouver") != nil{
                    // seperate movie info
                    var movies = theater.componentsSeparatedByString("<div class=movie>")
                    let theaterinfo = movies.removeAtIndex(0)
                    for movie in movies{
                        var flag = false
                        var title = movie.componentsSeparatedByString("<span class=info>")[0]
                        title = (title.componentsSeparatedByString(">")[2]).componentsSeparatedByString("<")[0]
                        for eachMovie in newPoll.movieOptions{
                            if title == eachMovie.title{
                                // already populated. add location/time data
                                flag = true
                                var times = (movie.componentsSeparatedByString("<div class=times>")[1]).componentsSeparatedByString("-->")
                                times.removeAtIndex(0)
                                var timearray: [String] = []
                                for time in times{
                                    timearray.append(time.componentsSeparatedByString("</span>")[0])
                                }
                                eachMovie.locationsAndTimes?.append(("Scotiabank Theatre Vancouver", timearray))
                            }
                        }
                        if flag == false {
                            // movie wasn't found. Append and populate new object
                            let info = (movie.componentsSeparatedByString("<span class=info>")[1]).componentsSeparatedByString("<a href")[0]
                            let length = info.componentsSeparatedByString(" -")[0]
                            var rated : String
                            if info.rangeOfString("Rated") != nil{
                                rated = (info.componentsSeparatedByString("Rated ")[1]).componentsSeparatedByString(" -")[0]
                            }
                            else{
                                rated = ""
                            }
                            var times = (movie.componentsSeparatedByString("<div class=times>")[1]).componentsSeparatedByString("-->")
                            times.removeAtIndex(0)
                            var timearray: [String] = []
                            for time in times{
                                timearray.append(time.componentsSeparatedByString("</span>")[0])
                            }
                            
                            newPoll.movieOptions.append(Movie(title: title, imdbRating: 0.0, length: length, genre: "", locationsAndTimes: [("Scotiabank Theatre Vancouver", timearray)], plot: "", poster: "", movieRating: rated))
                            newPoll.movieOptions.last?.getMovieInfo()
                            
                            print(newPoll.movieOptions)
                        }
                    }
                }
            }
        }
        
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Options"
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return "Add a minimum of 2 options for this poll"
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : newPoll.movieOptions.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 60.0 : self.tableView.rowHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = (indexPath.section == 0) ? "addCell" : "optionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        if indexPath.section == 1 {
            cell.textLabel?.text = newPoll.movieOptions[indexPath.row].title
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return (indexPath.section == 0) ? false : true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            newPoll.movieOptions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            if newPoll.movieOptions.count > 1 {
                nextButton.enabled = true
            } else {
                nextButton.enabled = false
            }
        }
    }

    
    // MARK: - Text Field Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Create new option
        let count = tableView.numberOfRowsInSection(1)
        
        if let title = textField.text where !title.isEmpty {
            let newOption = Movie(title: title)
            newPoll.addOption(newOption)
            
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: count, inSection: 1)], withRowAnimation: .Automatic)
            
            if newPoll.movieOptions.count > 1 {
                nextButton.enabled = true
            } else {
                nextButton.enabled = false
            }
            
            // Reset add text field
            textField.text = nil
            textField.becomeFirstResponder()
            
            return true
        }
        
        return false
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inviteFriends" {
            if let vc = segue.destinationViewController as? AddPollTVC_InviteFriends_Movie {
                vc.newPoll = newPoll
            }
        }
    }

}
