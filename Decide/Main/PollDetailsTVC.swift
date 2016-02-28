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
        
        // Remove tableview gap
        tableView.tableHeaderView = UIView(frame: CGRectMake(0.0, 0.0, tableView.bounds.size.width, 0.01))
        
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
        switch((indexPath.section, indexPath.row)) {
        case (0,0):                 // Title cell
            let identifier = "titleCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            cell.textLabel?.text = poll.title
            return cell
        case (1, _):                // Option cells
            let identifier = "optionCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PollOptionCell
            let option = poll.options[indexPath.row]
            
            cell.pollTitleLabel.text = option.title
            updateCellDetails(cell, option: option)
            
            return cell
        default:
            let identifier = "otherCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            return cell
        }
    }
    
    func updateCellDetails(cell: PollOptionCell, option: Option) {
        let count = option.votes.count
        
        cell.pollCountLabel.text = String(count)
        
        if count == 0 {
            cell.pollSubtitleLabel?.text = "No votes"
        } else {
            cell.pollSubtitleLabel?.text = returnObjectNames(option).joinWithSeparator(", ")
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
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? PollOptionCell {
            if let user = currentUser {
                let option = poll.options[indexPath.row]
                option.voteFor(withVoter: user)
                updateCellDetails(cell, option: option)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? PollOptionCell {
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
