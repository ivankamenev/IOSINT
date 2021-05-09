//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Ivan Kamenev on 12.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var tabBarController: UITabBarController?
    
    init(navigationController: UINavigationController?, tabBarController: UITabBarController?) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let profileVC = LogInViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileVC)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, tabBarController: nil)
        let profile = UITabBarItem(title: "Profile", image:UIImage(systemName: "person") , tag: 0)
        profileVC.delegate = LoginInspector()
        profileVC.coordinator = profileCoordinator
        profileVC.tabBarItem = profile
        
        let feedVC = FeedViewController(output: PostPresenter())
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        let feed = UITabBarItem(title: "Feed", image: UIImage(systemName: "info.circle"), tag: 1)
        feedVC.coordinator = FeedCoordinator(navigationController: feedNavigationController, tabBarController: nil)
        feedVC.tabBarItem = feed

        tabBarController?.viewControllers = [profileNavigationController, feedNavigationController]
    }
}
