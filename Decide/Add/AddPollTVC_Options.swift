//
//  AddPollTVC_Options.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollTVC_Options: UITableViewController, UITextFieldDelegate {
    
    var newPoll: Poll!
    
    @IBOutlet var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
        
        if newPoll.options.count > 1 {
            nextButton.enabled = false
        } else {
            nextButton.enabled = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if let addCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) {
            if addCell.isKindOfClass(AddPollTVC_Options_AddCell) {
                (addCell as! AddPollTVC_Options_AddCell).addOptionTextField.becomeFirstResponder()
            }
        }
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
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return "Add a minimum of 2 options for this poll"
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : newPoll.options.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 60.0 : self.tableView.rowHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = (indexPath.section == 0) ? "addCell" : "optionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        if indexPath.section == 1 {
            cell.textLabel?.text = newPoll.options[indexPath.row].title
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return (indexPath.section == 0) ? false : true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            newPoll.options.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            if newPoll.options.count > 1 {
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
            let newOption = Option(title: title)
            newPoll.addOption(newOption)
            
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: count, inSection: 1)], withRowAnimation: .Automatic)
            
            if newPoll.options.count > 1 {
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
            if let vc = segue.destinationViewController as? AddPollTVC_InviteFriends {
                vc.newPoll = newPoll
            }
        }
    }

}
