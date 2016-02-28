//
//  AddPollVC_TheatersAndTimes_Movie.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollTVC_TheatersAndTimes_Movie: UITableViewController, UITextFieldDelegate {
    
    var movie: Movie?
    
    //@IBOutlet weak var pollTitle: UILabel!
    
    
    // MARK: - View methods
    
    override func viewDidLoad() {
        //pollTitle.text = movie?.title
        super.viewDidLoad()
        
        //let cell = tableView.
        
        
        //cell.textLabel?.text = newPoll.movieOptions[indexPath.row].title
    }
    
    
    @IBAction func dismissDetail(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation
    
//    @IBAction func dismissDetails(sender: UIBarButtonItem) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
   // override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let identifier = (indexPath.section == 0) ? "addCell" : "optionCell"
//        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
//        
//        
//        cell.textLabel?.text = newPoll.movieOptions[indexPath.row].title
        
        
        //return cell
    //}
}