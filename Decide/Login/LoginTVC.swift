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
import CoreLocation

class LoginTVC: UIViewController, FBSDKLoginButtonDelegate, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let _ = FBSDKAccessToken.currentAccessToken() {
            proceedToApp()
        } else {
            let loginButton = FBSDKLoginButton()
            loginButton.readPermissions = ["email", "public_profile", "user_friends"]
            loginButton.center = self.view.center
            self.view.addSubview(loginButton)
        }
        
<<<<<<< HEAD
        // Set up location services
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //Keep this optional check, optional will have nil at first call otherwise and will throw error
        if let latitude = locationManager.location?.coordinate.latitude {
            let test = Poll(withUID: 1002,  title: "Alivepool", optionIds: [1,2,3], winningOptionId: 1003, theme: PollType.Movie, latitude: latitude, longitude: locationManager.location!.coordinate.longitude)
        
            test.populateNearbyMovies()
        }
        
    
=======
<<<<<<< HEAD
        let test = Movie(withUID: 1001, fk_uid: 1002, title: "Deadpool")
        test.getMovieInfo()
        test.scrapeMoviesNearMe()
=======
//        if let _ = FBSDKAccessToken.currentAccessToken() {
//            getProfile()
//            self.performSegueWithIdentifier("loggedIn", sender: nil)
//        } else {
//            let manager = LoginManager()
//            manager.facebookLogin { (credential, token) -> Void in
//                if let _ = FBSDKAccessToken.currentAccessToken() {
//                    self.getProfile()
//                    self.performSegueWithIdentifier("loggedIn", sender: nil)
//                }
//            }
//        }
>>>>>>> master
>>>>>>> master
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Facebook Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if !result.isCancelled && error == nil {
            proceedToApp()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Logged out!")
    }
    
    
    // MARK: - Navigation

    func proceedToApp() {
        let request = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "email"])
        request.startWithCompletionHandler({ (connection, result, error) in
            if let email = result.valueForKey("email") as? String {
                if let fbID = result.valueForKey("id") as? String {
                    let profile = FBSDKProfile.currentProfile()
                    let user = User(withFirstName: profile.firstName, lastName: profile.lastName, email: email, fb_id: fbID)
                    
                    if user.saveUser() {
                        print("\(FBSDKProfile.currentProfile().firstName) logged in!")
                        self.performSegueWithIdentifier("loggedIn", sender: nil)
                    }
                }
            }
            
            self.performSegueWithIdentifier("loggedIn", sender: nil)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.destinationViewController)
    }
 
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

    }
}
