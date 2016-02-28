//
//  AddPollTVC.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit
import CoreLocation

class AddPollTVC_Movie: UITableViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    var newPoll: MoviePoll!
    var locationManager: CLLocationManager!
    
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var pollTitleTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        newPoll = MoviePoll(title: "")
        super.init(coder: aDecoder)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newPoll.title.isEmpty {
            nextButton.enabled = false
        }
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //Keep this optional check, optional will have nil at first call otherwise and will throw error
        if let latitude = locationManager.location?.coordinate.latitude {
            //send lat and long to a movie poll
            newPoll.latitude = latitude
            newPoll.longitude = (locationManager.location?.coordinate.longitude)!
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
        pollTitleTextField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return (newPoll.title.isEmpty) ? false: true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addOptions" {
            if let vc = segue.destinationViewController as? AddPollTVC_Options_Movie {
                vc.newPoll = newPoll
            }
        }
    }

}
