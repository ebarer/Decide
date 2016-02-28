//
//  LoginTVC.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit
import Accounts
import FBSDKCoreKit
import FBSDKLoginKit

class LoginTVC: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ensure we can access the user profile
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        
        if let access = FBSDKAccessToken.currentAccessToken() {
            print("Logged In \(access)")
        } else {
            let loginButton = FBSDKLoginButton()
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.center = self.view.center
            self.view.addSubview(loginButton)
        }
        
        let test = Movie(withUID: 1001, fk_uid: 1002, title: "Deadpool")
        test.getMovieInfo()
        test.scrapeMoviesNearMe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print ("User Logged In!")
        
        if let error = error {
            print("Error: \(error)")
        } else if result.isCancelled {
            print("Cancelled")
        } else {
            print(result)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print ("User logged out!")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.destinationViewController)
    }

}
