//
//  AppDelegate.swift
//  CardWalletSDKTestApp
//
//  Created by Kagan Ozupek on 10.10.2018.
//  Copyright © 2018 Kagan Ozupek. All rights reserved.
//

import UIKit
import CardWalletSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CardWalletCredentialsProvider {
   
    
    func getCredentials(didCredentialsReceived:((CardWalletCredentials) -> ())?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            let defs = UserDefaults.standard

            didCredentialsReceived!(
                //stg
                CardWalletCredentials(token: "Bearer \(defs.string(forKey: "TOKEN")!)", partnerId: defs.string(forKey: "PARTNER")!)
            
                //dev
                //CardWalletCredentials(token: "Bearer eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0eXAiOiJCQVBGRVMiLCJzdWIiOiJjYWdyaS1zdWItb3NtYW4tb2gtb2giLCJpYXQiOjE1NDQ3ODY4MzB9.MgTFq5MRHyhuZhqcnUS0rSw9_zsUfw4yhntU-iZOeU7PksATa2EsQWYDSQr8xEPWWqfrKFutilR_yqKrUahlAMS71Cn4vXdrNk_-7PBXJTF0UcUEPyq1qonkPAAwHXUPvF9SzT_g5yijKBVYeN99F4gthVqJZwnHYtJBdLuHXgRD5zEWwUOwsevxypy8Jpc9_swlVt5XjXRWEXNQk_a8BKvIFnfO2mrMY4yEYyDkD1dAT8_Uuc5C2zPgWcXUzhDnFYVcb2ZsZGEKqqL1D-Of2wNzTSqMeM1uPzHCrlHoMwMgT1fUoWV9tjPOZ05jC3x3D2wq7ia80tPr1LcuC2-X5g", partnerId: "")
                
            )
        }
    }


    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let builder = CardWalletSDKBuilder()
            .setEnvironment(environment: Environment.STAGING)
            .setCredentialsProvider(provider: self)
           // .setLiveCardValidationCustomErrors(errors: [
           //     CWError.CWInvalidCVV : "CVC Invalid Custom Message"
           //     ])
        CardWalletSDK.start(builder: builder)
        
        CardWalletSDKSetup.sharedInstance.cardWalletStatusBarStyle = .default
        CardWalletSDKSetup.sharedInstance.cardWalletAddCardViewTitle = "dfsds"
        CardWalletSDKSetup.sharedInstance.cardWalletErrorLblTextColor = .green
        CardWalletSDKSetup.sharedInstance.cardWalletTextFieldTextColor =  .yellow
        CardWalletSDKSetup.sharedInstance.cardWalletTextFieldFont = UIFont(name: "Avenir-Black", size: 21)!
        CardWalletSDKSetup.sharedInstance.cardWalletLblFont = UIFont.systemFont(ofSize: 20)
        CardWalletSDKSetup.sharedInstance.cardWalletErrorLblFont = UIFont.systemFont(ofSize: 15)
        CardWalletSDKSetup.sharedInstance.cardWalletFontName = "Avenir-Black"
        CardWalletSDKSetup.sharedInstance.cardWalletScanCardBorderColor = .yellow
        CardWalletSDKSetup.sharedInstance.cardWalletDisableAutoNextField = false
        CardWalletSDKSetup.sharedInstance.cardWalletDisableChangeTextFieldColorWhenError = false
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
