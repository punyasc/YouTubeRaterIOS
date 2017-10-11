//
//  VideoRatingCell.swift
//  YTRaterTest
//
//  Created by Punya Chatterjee on 7/29/17.
//  Copyright © 2017 Punya Chatterjee. All rights reserved.
//

import UIKit

class VideoRatingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var dislikeNumLabel: UILabel!
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
