//
//  AddPollTVC_InviteFriends.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollTVC_InviteFriends: UITableViewController {
    
    //var newPoll: Poll!
    var newPoll = Poll(title: "Hello")
    var friends = [String: [User]]()
    var sectionTitles = [String]()

    @IBOutlet var inviteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
        
        if let selected = self.tableView.indexPathsForSelectedRows where selected.count > 0 {
            inviteButton.enabled = true
        } else {
            inviteButton.enabled = false
        }
        
        // Load friends
        let request = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "friends{picture,first_name,last_name,email}"])
        request.startWithCompletionHandler({ (connection, result, error) in
            if let data = result["friends"]?["data"] as? NSArray {
                var friendArray = [User]()
                
                for object in data {
                    guard let firstName = object["first_name"] as? String else { print("Bad value"); break }
                    guard let lastName = object["last_name"] as? String else { print("Bad value"); break }
                    guard let fbID = object["id"] as? String else { print("Bad value"); break }
                    
                    let newUser = User(withFirstName: firstName, lastName: lastName, email: nil, fb_id: fbID)
                    if let pictureURL = object["picture"]?["data"]?["url"] as? String {
                        newUser.profilePicture = NSURL(string: pictureURL)!
                    }
                    
                    friendArray.append(newUser)
                }
                
                friendArray.sortInPlace({$0.firstName < $1.firstName})
                
                // Get section titles
                var temp = Set<String>()
                for friend in friendArray {
                    temp.insert(friend.firstName[0])
                }
                self.sectionTitles = temp.sort({ $0 < $1 })
                
                // Sort friends into sections
                for section in self.sectionTitles {
                    let users = friendArray.filter({$0.firstName[0] == section})
                    self.friends.updateValue(users, forKey: section)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        })
        
        // Invite friends to app
//        let content = FBSDKAppInviteContent()
//        content.appLinkURL = NSURL(string: "http://www.ebarer.com")!
//        let dialog = FBSDKAppInviteDialog()
//        dialog.content = content
//        dialog.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sectionTitles[section]
        if let count = friends[section]?.count {
            return count
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath)
        let section = sectionTitles[indexPath.section]
        
        if let section = friends[section] {
            let friend = section[indexPath.row]
            
            if let url = friend.profilePicture {
                let imageView = UIImageView()
                imageView.imageFromURL(url)
                cell.imageView?.image = imageView.image
            }// Specify selection color
            cell.selectedBackgroundView = UIView()
            
            cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
            
            // Specify selection color
            cell.selectedBackgroundView = UIView()
        }

        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let selected = self.tableView.indexPathsForSelectedRows where selected.count > 0 {
            inviteButton.enabled = true
        } else {
            inviteButton.enabled = false
        }
    }

    
    // MARK: - Navigation

    @IBAction func createPoll(sender: AnyObject) {
        if let indexes = self.tableView.indexPathsForSelectedRows where indexes.count > 0 {
            // Set self as admin
            newPoll.admin = currentUser
            
            // Update poll with invited friends
            for selected in indexes {
                if let user = friends[sectionTitles[selected.section]]?[selected.row] {
                    newPoll.users.append(user)
                }
            }
            
            // Add poll to global array
            polls.append(newPoll)
            
            NSNotificationCenter.defaultCenter().postNotificationName("refreshPolls", object: nil)
            
            // Update MainPollsTVC
//            if let tbc = self.presentingViewController as? MainTBC {
//                if let nvc = tbc.viewControllers![0] as? UINavigationController {
//                    if let vc = nvc.topViewController as? MainPollsTVC {
//                        vc.tableView.reloadData()
//                    }
//                }
//            }
            
            // Dismiss and push to poll details
            dismissViewControllerAnimated(true, completion: {
                print("Push to details")
            })
        }
    }

}

extension String {
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}

extension UIImageView {
    public func imageFromURL(url: NSURL) {
        let request = NSURLRequest(URL: url)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let imageData = data as NSData? {
                self.image = UIImage(data: imageData)
            }
        }
    }
}