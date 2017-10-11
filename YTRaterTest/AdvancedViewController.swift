//
//  AdvancedViewController.swift
//  YTRaterTest
//
//  Created by Punya Chatterjee on 7/6/17.
//  Copyright © 2017 Punya Chatterjee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AdvancedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        channelField.text = ""
        ratings.removeAll()
    }
    
    @IBOutlet weak var actIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var channelField: UITextField!
    @IBAction func goAdvButton(_ sender: Any) {
        view.endEditing(true)
        let channel = channelField.text!
        let trimmedChannel = channel.trimmingCharacters(in: .whitespaces)
        channelNameFound = trimmedChannel
        youtubeDataCall(trimmedChannel)
    }
    
    
    var ratings = [VideoRating]()
    var channelNameFound: String? = nil
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(_ msg: String) {
        // create the alert
        let alert = UIAlertController(title: "Error getting YouTube data", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func youtubeDataCall(_ channelName: String) {
        print("There!")
        _ = "AIzaSyC8xUZuOyRsWFNDl0V6MCKtnxkx4kr38Vo"
        let channelAPI = "https://www.googleapis.com/youtube/v3/channels?forUsername=\(channelName)&key=AIzaSyC8xUZuOyRsWFNDl0V6MCKtnxkx4kr38Vo&part=id"
        actIndicatorView.startAnimating()
        Alamofire.request(channelAPI).responseJSON { response in
            
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                if let id = json["items"][0]["id"].string {
                    print("the id of \(channelName) is \(id)")
                    let maxResults = 10
                    let ordering = "date"
                    let videoListReqByIdURL = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyC8xUZuOyRsWFNDl0V6MCKtnxkx4kr38Vo&channelId=\(id)&part=id&maxResults=\(maxResults)&order=\(ordering)"
                    
                    Alamofire.request(videoListReqByIdURL).responseJSON { response in
                        if response.result.value != nil {
                            let json = JSON(response.result.value!)
                            let videoArray = json["items"].arrayValue
                            print(type(of: videoArray))
                            print(videoArray.count)
                            var idChain = ""
                            var numIds = 0
                            //Add video IDs to the idchain
                            let someString = videoArray[0].stringValue
                            print("array 0: \(videoArray[0].stringValue)")
                            if videoArray.count <= 1 && videoArray[0]["id"]["videoId"].stringValue == "" {
                                self.actIndicatorView.stopAnimating()
                                self.showAlert("No videos found for this user.")
                            }
                            
                            for video in videoArray {
                                let videoId = video["id"]["videoId"].stringValue
                                idChain += videoId + ","
                                numIds += 1
                            }
                            
                            let videosRequestURL = "https://www.googleapis.com/youtube/v3/videos?key=AIzaSyC8xUZuOyRsWFNDl0V6MCKtnxkx4kr38Vo&part=snippet,statistics&id=\(idChain)"
                            Alamofire.request(videosRequestURL).responseJSON { response in
                                if response.result.value != nil {
                                    print("THE URL IS: \(videosRequestURL)")
                                    let json = JSON(response.result.value!)
                                    let videoStatArray = json["items"].arrayValue
                                    for vidStat in videoStatArray {
                                        let numLikes = vidStat["statistics"]["likeCount"]
                                        let numDislikes = vidStat["statistics"]["dislikeCount"]
                                        let videoName = vidStat["snippet"]["title"]
                                        let thumbURLSmall = vidStat["snippet"]["thumbnails"]["default"]
                                        let outString = ("\(videoName) has \(numLikes) likes and \(numDislikes) dislikes\n\n")
                                        /*
                                        self.advTextView.text = self.advTextView.text + outString*/
                                        self.actIndicatorView.stopAnimating()
                                        /*
                                        guard let numLikes = Int(numLikes) as? Int else { return }
                                        guard let numDislikes Int(numDislikes) as? Int else (return)
                                        */
                                        let thisRating = VideoRating(ttl: videoName.stringValue, lk: numLikes.intValue, dslk: numDislikes.intValue)
                                        self.ratings.append(thisRating)
                                    }
                                    
                                    /* ALL REQUESTS COMPLETED */
                                    
                                    self.performSegue(withIdentifier: "ResultTableSegue", sender: nil)
                                    
                                    
                                } else {
                                    //Failed to get video statistics for list
                                    self.actIndicatorView.stopAnimating()
                                    self.showAlert("Failed to get video statistics for video list.")
                                }
                            }
                        } else {
                            //Video list request failed
                            self.actIndicatorView.stopAnimating()
                            self.showAlert("Video list request failed.")
                            
                        }
                    }
                } else {
                    //Invalid channel
                    self.actIndicatorView.stopAnimating()
                    self.showAlert("Could not find channel.")
                }
            } else {
                //Channel API request failed
                self.actIndicatorView.stopAnimating()
                self.showAlert("Channel API request failed.")
            }
        }
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let table = segue.destination as? VideoRatingTableViewController {
            print("*************\n\n FIRST ITEM: \(ratings[0].title) \n\n\n\n **************")
            table.ratings = self.ratings
            guard let channelNameFound = channelNameFound else { return}
            table.navigationItem.title = "Videos by \(channelNameFound)"
        }
        
    }
    

}
