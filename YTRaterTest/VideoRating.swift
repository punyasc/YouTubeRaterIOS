//
//  VideoRating.swift
//  YTRaterTest
//
//  Created by Punya Chatterjee on 7/29/17.
//  Copyright © 2017 Punya Chatterjee. All rights reserved.
//

import Foundation

struct VideoRating {
    var title: String
    var numLikes: Int
    var numDislikes: Int
    var rating: Double {
        if numDislikes == 0 { return 0 }
        let dubLikes = Double(numLikes)
        let dubDislikes = Double(numDislikes)
        let result = dubLikes / (dubDislikes + dubLikes)
        return Double(round(100*result)/100)
    }
    
    init(ttl: String, lk: Int, dslk: Int) {
        title = ttl
        numLikes = lk
        numDislikes = dslk
    }
}
