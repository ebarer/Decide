//
//  AddPollVC_TheatersAndTimes_Movie.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollVC_TheatersAndTimes_Movie: UIViewController, UITextFieldDelegate {
    
    var movie: Movie?
    
    @IBOutlet weak var pollTitle: UILabel!
    
    
    // MARK: - View methods
    
    override func viewDidLoad() {
        pollTitle.text = movie?.title
    }
    
    
    // MARK: - Navigation
    
    @IBAction func dismissDetails(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}