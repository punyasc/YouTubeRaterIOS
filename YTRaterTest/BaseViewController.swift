//
//  ViewController.swift
//  YTRaterTest
//
//  Created by Punya Chatterjee on 7/3/17.
//  Copyright © 2017 Punya Chatterjee. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire


class BaseViewController: UIViewController {
    
    @IBOutlet weak var viewBas: UIView!
    @IBOutlet weak var viewAdv: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("working!")
        // Do any additional setup after loading the view, typically from a nib.
        //vcBasic.alpha = 1
        viewBas.alpha = 1
        viewAdv.alpha = 0
        //vcAdvanced.alpha = 0
        //basicViewC.alpha = 1
        //advViewC.alpha = 0
        //youtubeDataCall()
        print("Here!")
        print("I still work")
    }
    
    

    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    


}

