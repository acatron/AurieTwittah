//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by user on 2/18/16.
//  Copyright © 2016 Aurielle. All rights reserved.
//

import UIKit


class TweetsTableViewCell: UITableViewCell {
    
  

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        userNameLabel.preferredMaxLayoutWidth = userNameLabel.frame.size.width
        
        
        // Initialization code
    }

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeCreatedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    
    
    
    class Tweet: NSObject {
        
        var user: User?
        var author: String?
        var text: String?
        var createdAtString: String?
        var createdAt: NSDate?
        var id: String
        var favTotal: Int?
        var retweetTotal: Int?
        var tweetID: String = ""
        
        
        
        init(dictionary: NSDictionary) {
            
            
            text = dictionary["text"] as? String
            createdAtString = dictionary["created_at"] as? String
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            createdAt = formatter.dateFromString(createdAtString!)
            
            user = User(dictionary: dictionary["user"] as! NSDictionary )
            author = dictionary["author"] as? String
            
            favTotal = dictionary["favorite_count"] as? Int
            
            retweetTotal = dictionary ["retweet_count"] as? Int
            id = String(dictionary["id"]!)
            
            
            
            
            
            
            
            
        }
        
        class func tweetWithArray(array: [NSDictionary]) -> [Tweet] {
            var tweets = [Tweet]()
            
            for dictionary in array {
                print(dictionary)
                
                tweets.append(Tweet(dictionary: dictionary))
                
            }
            return tweets
        }
    }
    
    

    
    
    
    
    
    
    
        

    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
