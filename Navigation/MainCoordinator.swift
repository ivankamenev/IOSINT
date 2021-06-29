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
    private let stack: CoreDataStack
    
    init(navigationController: UINavigationController?, tabBarController: UITabBarController?, stack: CoreDataStack) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.stack = stack
    }
    
    func start() {
        let profileVC = LogInViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileVC)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, tabBarController: nil, stack: stack)
        let profile = UITabBarItem(title: "Profile", image:UIImage(systemName: "person") , tag: 0)
        profileVC.delegate = LoginInspector()
        profileVC.coordinator = profileCoordinator
        profileVC.tabBarItem = profile
        
        let feedVC = FeedViewController(output: PostPresenter())
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        let feed = UITabBarItem(title: "Feed", image: UIImage(systemName: "info.circle"), tag: 1)
        feedVC.coordinator = FeedCoordinator(navigationController: feedNavigationController, tabBarController: nil)
        feedVC.tabBarItem = feed
        
        let likesVC = LikesViewController(stack: stack)
        let likesNavigationController = UINavigationController(rootViewController: likesVC)
        let likes = UITabBarItem(title: "Likes", image: UIImage(systemName: "suit.heart"), selectedImage: nil)
        likesVC.tabBarItem = likes

        tabBarController?.viewControllers = [profileNavigationController, feedNavigationController, likesNavigationController]
    }
}
