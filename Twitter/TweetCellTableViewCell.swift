//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by John Jakobsen on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    var favorited: Bool = false
    var retweeted: Bool = false
    var tweetId: Int = -1
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setfavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: .normal)
        } else {
            favButton.setImage(UIImage(named:"favor-icon"), for: .normal)
        }
    }
    func setretweet(_ isretweeted: Bool) {
        retweeted = isretweeted
        if (retweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: .normal)
        }
    }
    
    @IBAction func favTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if (tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setfavorite(true)
            }, failure: { (Error) in
                print("Favorite went wrong \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setfavorite(false)
            }, failure: { (Error) in
                print("unFavorite went wrong \(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setretweet(true)
        }, failure: { (Error) in
            print("Something went wrong retweeting \(Error)")
        })
        
    }
    

}
