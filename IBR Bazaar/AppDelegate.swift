//
//  AppDelegate.swift
//  IBR Bazaar
//
//  Created by Monish M S on 21/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        if userDefaults.GET_USERDEFAULTSSTATUS(objectValue: "loginComplete"){
            settabbarRootVC()
        }else{
            setThisViewControllerWithIdentifierAsRoot(identifier: "MobileVerificationVC", InStoryBoard: "Main")
        }
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

extension AppDelegate{
    
    func settabbarRootVC(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        UIApplication.shared.keyWindow?.rootViewController = viewController
        let color = UIColor(red: 239.0/255.0, green: 189.0/255.0, blue: 9.0/255.0, alpha: 1.0)
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    
    func setThisViewControllerWithIdentifierAsRoot(identifier:String, InStoryBoard storyBoard:String) -> Void {
        let storyboard = UIStoryboard(name: storyBoard, bundle: nil);
        let VC = storyboard.instantiateViewController(withIdentifier: identifier)
        window?.rootViewController = VC
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
