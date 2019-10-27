//
//  AppDelegate.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/15/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let dataController = DataController(modelName: "WordNerd")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dataController.load()
        
        let navigationController = window?.rootViewController as! UINavigationController
        let dailyWordViewController = navigationController.topViewController as! DailyWordViewController
        dailyWordViewController.dataController = dataController
        
        return true
    }
    
}

