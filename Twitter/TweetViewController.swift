//
//  TweetViewController.swift
//  Twitter
//
//  Created by John Jakobsen on 10/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var remainingCharLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.becomeFirstResponder()
        tweetTextField.layer.cornerRadius = 5
        tweetTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let charLimit = 140
        
        let newText = NSString(string: tweetTextField.text!).replacingCharacters(in: range, with: text)
        remainingCharLabel.text = "\(140 - newText.count) Remaining Characters"
        return newText.count < charLimit
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tweet(_ sender: Any) {
        if (tweetTextField.text.isEmpty) {
            self.dismiss(animated: true)
            return
        }
        TwitterAPICaller.client?.postTweet(tweetString: tweetTextField.text, success: {self.dismiss(animated: true)}, failure: { (Error) in
            print("Error posting tweet \(Error)")
        })
        
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
