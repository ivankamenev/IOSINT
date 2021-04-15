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
    var appCoordinator: MainCoordinator?
    var vc = MainTabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = MainTabBarController()
//        window?.makeKeyAndVisible()
        appCoordinator = MainCoordinator(window: window!, vc: vc)
        appCoordinator?.start()
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
