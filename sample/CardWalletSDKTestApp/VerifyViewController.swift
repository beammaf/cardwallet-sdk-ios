//
//  VerifyViewController.swift
//  CardWalletSDKTestApp
//
//  Created by Kagan Ozupek on 10.12.2018.
//  Copyright © 2018 Kagan Ozupek. All rights reserved.
//

import UIKit
import CardWalletSDK

class VerifyViewController: UIViewController {

    @objc public var card : CreditCard!
    
    
    @IBOutlet weak var et: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    } 
    
    @IBAction func cl(_ sender: Any) {
        if Double(et.text!) != nil{
            
            HudManager.shared.showHud(controller: self)
            CardWalletSDK.shared().verifyCreditCard(cardToken: card.cardToken, verifiedAmount: et.text!, success: { (cc) in
                
                self.navigationController?.popViewController(animated: true)
                HudManager.shared.dismissHud()
                
            }) { (error) in
                HudManager.shared.dismissHud()
                HudManager.shared.showHud(controller: self, message: "ERROR CODE:\(error!.errorDescription)\n\(error!.errorCode)")

            }
        }
    }
    
    

}
