//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())

        appCoordinator = AppCoordinator(tabBarController: UITabBarController(), childCoordinators: [feedCoordinator, profileCoordinator])
        appCoordinator?.start()
        window?.rootViewController = appCoordinator?.tabBarController
        window?.makeKeyAndVisible()
        return true
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
//  2021-03-19 17:19:27.642792+0300 Navigation[77732:15176277] [BackgroundTask] Background Task 3 ("Called by Navigation, from $s10Navigation18FeedViewControllerC14viewWillAppearyySbF"), was created over 30 seconds ago. In applications running in the background, this creates a risk of termination. Remember to call UIApplication.endBackgroundTask(_:) for your task in a timely manner to avoid this.
        print(type(of: self), #function)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(type(of: self), #function)
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print(type(of: self), #function)
        return true
    }
}
