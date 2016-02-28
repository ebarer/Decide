//
//  PollDetailsTVC.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class PollDetailsTVC: UITableViewController, UITextFieldDelegate {
    
    var poll: Poll!
    
    @IBOutlet var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Select options
        self.tableView.editing = true
        if let user = currentUser {
            for (row, option) in poll.options.enumerate() {
                let index = NSIndexPath(forRow: row, inSection: 1)
                
                if option.votes.users.contains(user) {
                    self.tableView.selectRowAtIndexPath(index, animated: true, scrollPosition: .None)
                } else {
                    self.tableView.deselectRowAtIndexPath(index, animated: true)
                }
            }
        }
        print(poll.toDict())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : poll.options.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 80.0 : self.tableView.rowHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = (indexPath.section == 0) ? "titleCell" : "optionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        switch((indexPath.section, indexPath.row)) {
        case (0,0):                 // Title cell
            cell.textLabel?.text = poll.title
        case (1, _):                // Option cells
            let option = poll.options[indexPath.row]
            cell.textLabel?.text = option.title
            updateCellDetails(cell, option: option)
        default: break
        }
        
        return cell
    }
    
    func updateCellDetails(cell: UITableViewCell, option: Option) {
        let count = option.votes.count
        
        if count == 0 {
            cell.detailTextLabel?.text = "No votes"
        } else {
            cell.detailTextLabel?.text = "\(option.votes.count) votes: \(returnObjectNames(option).joinWithSeparator(", "))"
        }
        
        if let user = currentUser {
            cell.selected = option.votes.users.contains(user)
        }
    }
    
    
    // MARK: - Voting actions
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch((indexPath.section, indexPath.row)) {
        case (0,0):         // Title cell
            return false
        default:
            return true
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if let user = currentUser {
                let option = poll.options[indexPath.row]
                option.voteFor(withVoter: user)
                updateCellDetails(cell, option: option)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if let user = currentUser {
                let option = poll.options[indexPath.row]
                option.unvoteFor(withVoter: user)
                updateCellDetails(cell, option: option)
            }
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.destinationViewController)
    }
    
}
