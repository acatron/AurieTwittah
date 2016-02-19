//
//  Tweet.swift
//  Twitter
//
//  Created by user on 2/18/16.
//  Copyright © 2016 Aurielle. All rights reserved.
//

import UIKit

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
    
//    
//    
//    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
//        
//        
//        // print(dictionary)
//        
//        let tweet = Tweet(dictionary: dict)
//        
//        return tweet
//    }
//    
    

    
}
