//
//  LoginManager.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-27.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import Accounts
import Social

class LoginManager: NSObject {
    
    var facebookAccount: ACAccount?
    
    func facebookLogin(completion: (credential: ACAccountCredential?, token: String?) -> Void) {
        let store = ACAccountStore()
        let facebook = store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
        let apiKey = "1134645039888778"
        let loginParameters: [NSObject: AnyObject] = [ACFacebookAppIdKey: apiKey, ACFacebookPermissionsKey: []]
        store.requestAccessToAccountsWithType(facebook, options: loginParameters) { granted, error in
            if granted {
                let accounts = store.accountsWithAccountType(facebook)
                self.facebookAccount = accounts.last as? ACAccount
                
                let credentials = self.facebookAccount?.credential
                let tokenString = credentials?.oauthToken
                let cal = NSCalendar.currentCalendar()
                let expiryDate = cal.dateByAddingUnit(NSCalendarUnit.Year, value: 1000, toDate: NSDate(), options: [])
                
                let token = FBSDKAccessToken(tokenString: tokenString,
                                             permissions: ["email", "public_profile", "user_friends"],
                                             declinedPermissions: [],
                                             appID: apiKey,
                                             userID: self.facebookAccount!.identifier,
                                             expirationDate: expiryDate,
                                             refreshDate: expiryDate)
                
                FBSDKAccessToken.setCurrentAccessToken(token)
                
                completion(credential: credentials, token: tokenString)
            } else {
                if let error = error {
                    print(error)
                }
                
                completion(credential: nil, token: nil)
            }
        }
    }

}