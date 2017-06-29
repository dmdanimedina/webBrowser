//
//  AppDelegate.swift
//  WebBrowser
//
//  Created by Samtech on 10-05-17.
//  Copyright © 2017 Samtech. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 10.0, *){
            let center = UNUserNotificationCenter.current()
                center.delegate = self
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler:{(grant, error) in
                if error == nil {
                    if grant {
                        application.registerForRemoteNotifications()
                    } else {
                        // user didnt grant
                    }
                } else {
                    print("Error: ", error as Any )
                }
            })
        }else {
                // fallback on earlier versions
            let notificationSettings = UIUserNotificationSettings( types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(notificationSettings)
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings){
        if notificationSettings.types != .none{
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        let tokenString = deviceToken.reduce("",{$0 + String(format:"%02X", $1)})
        
        print("token :", tokenString)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = storyboard
            .instantiateViewController(withIdentifier: "Main") as! ViewController
        UserDefaults.standard.register(defaults: ["token" : tokenString])
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
    }
    
    
  
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> ()) {
        
        print("Message ID \(userInfo["data"]!)")
         print("          ")
        print(userInfo)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = storyboard
            .instantiateViewController(withIdentifier: "Main") as! ViewController
        UserDefaults.standard.register(defaults: ["jsonDatas" : userInfo["data"]!])
        //let defaults = UserDefaults.standard
        //defaults.set(userInfo["data"] as! String, forKey: "jsonDatos")

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    

    
    func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
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

