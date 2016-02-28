//
//  MainPollsTVC.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class MainPollsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("refreshView"), name: "refreshPolls", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(index, animated: animated)
        }

        self.editButtonItem().enabled = (polls.count > 0)
    }
    
    func refreshView() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pollCell", forIndexPath: indexPath)
        let poll = polls[indexPath.row]
        
        cell.textLabel?.text = poll.title
        
        var names = [String]()
        for user in poll.users {
            names.append(user.firstName)
        }
        
        if names.count > 2 {
            cell.detailTextLabel?.text = "with \(names[0]), \(names[1]), and \(names.count - 2) others"
        } else {
            cell.detailTextLabel?.text = "with \(names.joinWithSeparator(", "))"
        }

        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selecting \(polls[indexPath.row])")
        // #DEBUG
        currentUser?.toDict()
        polls[indexPath.row].toDict()
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let poll = polls[indexPath.row]
        
        if poll.admin == currentUser {
            return true
        }
        
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let poll = polls[indexPath.row]
            polls.removeObject(poll)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewPollDetails" {
            if let vc = segue.destinationViewController as? PollDetailsTVC {
                if let index = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                    vc.poll = polls[index.row]
                }
            }
        }
    }

}
