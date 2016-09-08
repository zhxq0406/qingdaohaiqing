
//  AppDelegate.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/14.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

        if let barFont = UIFont(name: "ChalkboardSE-Bold", size: 18){
            UINavigationBar.appearance().titleTextAttributes = [
                NSForegroundColorAttributeName:UIColor.whiteColor(),
                NSFontAttributeName : barFont
            ]
        }
        
        
        
        
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        //增加标识，用于判断是否是第一次启动应用...
//        if (!(NSUserDefaults.standardUserDefaults().boolForKey("everLaunched"))) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"everLaunched")
            let  guideViewController = storyboard.instantiateViewControllerWithIdentifier("ScollViewController") as! ScollViewController
            self.window?.rootViewController=guideViewController;
            print("guideview launched!")
//        }

        
        
        
//启动加载的第一个页面
        
        
//        
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabbar")
//        self.window?.rootViewController = vc

        
        
        
        return true
    }

           func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}
