//
//  HudManager.swift
//  CardWalletSDKTestApp
//
//  Created by Kagan Ozupek on 13.12.2018.
//  Copyright © 2018 Kagan Ozupek. All rights reserved.
//

import Foundation

import MBProgressHUD

@objc class HudManager : NSObject {
    
    @objc static let shared = HudManager()
    var hud : MBProgressHUD!
    
    @objc public func showHud(controller : UIViewController,message : String? = nil){
        self.dismissHud()
      
        if let m = message{
            
            hud = MBProgressHUD.showAdded(to: returnCurrentView(controller: controller).view, animated: true)
            hud.mode = .text
            hud.label.numberOfLines = 0
            hud.label.text = m
            hud.hide(animated: true, afterDelay: 5.0)

        }else{
            hud = MBProgressHUD.showAdded(to: controller.view, animated: true)
        }
        
        
        
    }
    
    @objc public func dismissHud(){
        if(hud != nil){
            hud.hide(animated: true)
            hud = nil
        }
    }
    
    func returnCurrentView(controller : UIViewController) -> UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
            
        }
        return controller
    }
    
    
    
    
}
