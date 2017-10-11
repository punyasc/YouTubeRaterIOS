//
//  VideoRatingTableViewController.swift
//  
//
//  Created by Punya Chatterjee on 7/29/17.
//
//

import UIKit

class VideoRatingTableViewController: UITableViewController {
    
    var ratings = [VideoRating]()
    @IBOutlet var resultTable: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Results: \(ratings.count)")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ratings.removeAll()
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resultTable.reloadData()
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ratings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "VideoRatingTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VideoRatingTableViewCell  else {
            fatalError("The dequeued cell is not an instance of VideoRatingTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let rating = ratings[indexPath.row]
        
        cell.videoTitleLabel.text = String(rating.title)
        cell.likeNumLabel.text = String(rating.numLikes) + " likes"
        cell.dislikeNumLabel.text = String(rating.numDislikes) + " dislikes"
        cell.ratingLabel.text = String(rating.rating * 100) + "%"

        if (rating.rating > 0.6) {
            cell.thumbnailImageView.image = #imageLiteral(resourceName: "thumbsup")
            cell.thumbnailImageView.tintColor = .green
            cell.ratingLabel.textColor = .green
        } else {
            cell.thumbnailImageView.image = #imageLiteral(resourceName: "thumbsdown")
            cell.thumbnailImageView.tintColor = .red
            cell.ratingLabel.textColor = .red
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
