//
//  TweetsViewController.swift
//  Twitter
//
//  Created by user on 2/13/16.
//  Copyright © 2016 Aurielle. All rights reserved.
//

import UIKit
import AFNetworking


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    let delay = 2.0 * Double(NSEC_PER_SEC)
    
    
    var favButton: UIButton!
    var toggleFav = 2
    var toggleRetweet = 2
    // make sure is 2
 
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        

        // Do any additional setup after loading the view.
        
        TwitterClient.sharedInstance.homeTImelineWithParams(nil) { (tweets, error) -> () in
            if (tweets != nil) {
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    //        trying to implement button animation

    @IBAction func onTapRetweet(sender: UIButton) {
        if toggleRetweet == 1 {
            print("test on")
            toggleRetweet = 2
            sender.setImage(UIImage(named: "retweet-action-inactive"), forState: UIControlState.Normal)
        }else{
            toggleRetweet = 1
            sender.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
            print("else works?")
        }
    }
    
    @IBAction func onTapFav(sender: UIButton) {
        if toggleFav == 1 {
            print("tweet pressed")
            toggleFav = 2
        sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
        }else{
            toggleFav = 1
            sender.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
            print("twitter not pressed")
            //DO NOT TOUCH ONLY THING WORKNG
        }

//        sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
//        sender.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Selected)
//        sender.setImage(UIImage(named: "like-action-on-pressed-red"), forState: UIControlState.Highlighted)
//        
        print("change state of button")
    }
    
    
    
  

    
    
    func delay(delay:Double, closure:() -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(1, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            print("TWEETS COUNT:::::::::::::::::::::::: \(tweets!.count)")
            return tweets!.count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath) as! TweetsTableViewCell
        
        
        

        
        
        let imageUrl = tweets![indexPath.row].user?.profileImageUrl!
        cell.profileImageView.setImageWithURL(NSURL(string: imageUrl!)!)
        
        
        cell.tweetContent.text = tweets![indexPath.row].text!
        
        
        cell.userNameLabel.text = tweets![indexPath.row].user?.name!
        
        
        cell.timeCreatedLabel.text = tweets![indexPath.row].createdAtString!
        cell.authorLabel.text = "@" + tweets![indexPath.row].user!.screenname!
//
        cell.favCountLabel.text = String(tweets![indexPath.row].favTotal)
        cell.retweetCountLabel.text = String(tweets![indexPath.row].retweetTotal)
        
        
        

//        var retweetTotal = tweets![indexPath.row].retweetTotal
//
//        tweetID = tweet.id
//        retweetTotalLabel = String(tweets.retweetCount!)
//        favCountLabel.text = String(tweet.favCount!)
//        
//        
////        let favTotal = tweets![indexPath.row].favTotal!
////
////        
////        cell.favCountLabel.text = tweets![indexPath.row].favTotal as? String
//        

//
        
        return cell;
    }
    
    
    

    /*
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
