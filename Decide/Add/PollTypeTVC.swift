//
//  PollTypeTVC.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class PollTypeTVC: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected \(indexPath.row)")
    }

    
    // MARK: - Navigation

    @IBAction func cancelAddingPoll() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
