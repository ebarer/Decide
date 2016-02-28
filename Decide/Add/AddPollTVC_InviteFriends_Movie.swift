//
//  AddPollTVC_InviteFriends.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollTVC_InviteFriends_Movie: UITableViewController {
    
    var newPoll: MoviePoll!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath)

        cell.textLabel?.text = "Elliot Barer"

        return cell
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.destinationViewController)
    }

}
