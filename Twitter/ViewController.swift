//
//  ViewController.swift
//  Twitter
//
//  Created by user on 2/18/16.
//  Copyright © 2016 Aurielle. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogIn(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
            }else{
                //handle error
            }
        }
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "cptwitterjean://oauth"),
            scope: nil,
            success: {
                (requestToken: BDBOAuth1Credential!) -> Void in
                print("Got the request token")
                
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
                
            }) {
                (error: NSError!) -> Void in
                print("Failed to get request token")
        }
    }

}

