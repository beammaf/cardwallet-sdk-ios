//
//  TokenViewController.swift
//  FundingTestApp
//
//  Created by Kagan Ozupek on 27.12.2018.
//  Copyright © 2018 Kagan Ozupek. All rights reserved.
//

import Foundation
import UIKit
class TokenViewController : UIViewController{
    
    @IBOutlet weak var etToken: UITextView!
    @IBOutlet weak var etPartnerId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        etToken.text = defaults.string(forKey: "TOKEN")
        etPartnerId.text = defaults.string(forKey: "PARTNER")

    }
    

    @IBAction func CLGo(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(etToken.text!.trimmingCharacters(in: .whitespaces), forKey: "TOKEN")
        defaults.set(etPartnerId.text!.trimmingCharacters(in: .whitespaces), forKey: "PARTNER")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainNavController") as! UINavigationController
        self.present(newViewController, animated: true, completion: nil)
    }
}
