//
//  AddPollTVC.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollTVC: UITableViewController, UITextFieldDelegate {

    var pollTitle: String?
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var pollTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pollTitle == nil {
            nextButton.enabled = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        pollTitleTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func updateTitle(sender: UITextField) {
        pollTitle = sender.text
        
        if sender.text == nil || sender.text!.isEmpty {
            nextButton.enabled = false
        } else {
            nextButton.enabled = true
        }
    }
    
    
    // MARK: - Text Field Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        pollTitleTextField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return (pollTitle == nil) ? false: true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addOptions" {
            if let vc = segue.destinationViewController as? AddPollTVC_Options {
                if let pollTitle = pollTitle {
                    vc.newPoll = Poll(title: pollTitle)
                }
            }
        }
    }

}
