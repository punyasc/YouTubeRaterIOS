//
//  BasicViewController.swift
//  YTRaterTest
//
//  Created by Punya Chatterjee on 7/6/17.
//  Copyright © 2017 Punya Chatterjee. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    var hasHitGo = false
    @IBOutlet weak var bigStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeField.keyboardType = UIKeyboardType.numberPad
        dislikeField.keyboardType = UIKeyboardType.numberPad
        likeField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        dislikeField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBOutlet weak var likeField: UITextField!
    @IBOutlet weak var dislikeField: UITextField!
    @IBOutlet weak var basicLabel: UILabel!
    
    @IBAction func goButton(_ sender: Any) {
        view.endEditing(true)
        hasHitGo = true
        updateScore()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        guard hasHitGo else { return }
        updateScore()
    }
    
    func updateScore() {
        
        guard let likes = likeField.text else {
            /*showAlert("Invalid number of likes.")
            likeField.text = ""*/
            return }
        guard let dislikes = dislikeField.text else {
            /*showAlert("Invalid number of dislikes.")
            dislikeField.text = ""*/
            return }
        guard let likesDbl = Double(likes) else {
            /*showAlert("Please enter a valid number of likes.")
            likeField.text = ""*/
            return }
        guard let dislikesDbl = Double(dislikes) else {
            /*showAlert("Please enter a valid number of dislikes.")
            dislikeField.text = ""*/
            return }
        
        /*
        let likes = likeField.text!
        let dislikes = dislikeField.text!
        let likesDbl = Double(likes)!
        let dislikesDbl = Double(dislikes)! */
        
        let result = (likesDbl / (likesDbl + dislikesDbl)) * 100
        let roundedResult = Double(round(100*result)/100)
        basicLabel.text = "\(roundedResult)"
        
        switch roundedResult {
        case 60...100:
            basicLabel.textColor = .green
        case 0..<60:
            basicLabel.textColor = .red
        default:
            basicLabel.textColor = .black
        }
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func showAlert(_ msg: String) {
        // create the alert
        let alert = UIAlertController(title: "Invalid Input", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
