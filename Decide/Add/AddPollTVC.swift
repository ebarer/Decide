//
//  AddPollTVC.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollTVC: UITableViewController, UITextFieldDelegate {

    var newPoll: Poll
    
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var pollTitleTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        newPoll = Poll()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // #DEBUG
        if let text = pollTitleTextField.text {
            newPoll.title = text
            newPoll.options = [Option(title: "Test1"), Option(title: "Test2")]
        }
        
        if let title = newPoll.title where !title.isEmpty {
            nextButton.enabled = true
        } else {
            nextButton.enabled = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        pollTitleTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func updateTitle(sender: UITextField) {
        newPoll.title = sender.text!
        
        if sender.text == nil || sender.text!.isEmpty {
            nextButton.enabled = false
        } else {
            nextButton.enabled = true
        }
    }
    
    
    // MARK: - Text Field Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let title = newPoll.title where !title.isEmpty {
            performSegueWithIdentifier("addOptions", sender: nil)
            return true
        }
        
        return false
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if let title = newPoll.title where !title.isEmpty {
            return true
        } else {
            return false
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addOptions" {
            if let vc = segue.destinationViewController as? AddPollTVC_Options {
                vc.newPoll = newPoll
            }
        }
    }

}
