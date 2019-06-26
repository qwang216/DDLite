//
//  AppDelegate.swift
//  DDLite
//
//  Created by Jason wang on 6/20/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // If I had more time I would implement the Coordinator pattern
        // each viewcontroller shouldn't know about each other
        // the coordinator should handle all the navigation and passing data between viewcontrollers
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = MainTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }

}

