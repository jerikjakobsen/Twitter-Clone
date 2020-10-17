//
//  profileViewController.swift
//  Twitter
//
//  Created by John Jakobsen on 10/17/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class profileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var numberOfTweets: Int!
    var tweetsArray = [NSDictionary]()
    var user =  NSDictionary()
    @IBOutlet weak var tweetsTableView: UITableView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        loadTweets()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCellTableViewCell
        let user = tweetsArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as! String
        cell.tweetContent.text = tweetsArray[indexPath.row]["text"] as! String
        let profileUrl = user["profile_image_url_https"] as! String
        let imageUrl = URL(string: profileUrl)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            cell.profileImageView.image = UIImage(data:imageData)
        }
        cell.setfavorite(tweetsArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetsArray[indexPath.row]["id"] as! Int
        cell.setretweet(tweetsArray[indexPath.row]["retweeted"] as! Bool)
        return cell
    }
    
    @objc func loadTweets() {
        numberOfTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: NSDictionary() as! [String : Any], success: { (tweets: [NSDictionary]) in
            self.tweetsArray.removeAll()
            for tweet in tweets {
                self.tweetsArray.append(tweet)
            }
            if (self.tweetsArray.count > 0) {
                self.user = self.tweetsArray[0]["user"] as! NSDictionary
            }
            self.tweetsTableView.reloadData()
        }, failure: { (Error) in
            print("could not recieve Tweets \(Error)")
        })
    }

    func loadUser() {
        let profileUrl = self.user["profile_image_url_https"] as! String
        let bannerUrl = self.user["profile_banner_url"] as! String
        var imageUrl = URL(string: profileUrl)
        var data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            self.profileImageView.image = UIImage(data:imageData)
        }
        imageUrl = URL(string: bannerUrl)
        data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            self.bannerImageView.image = UIImage(data:imageData)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
