//
//  MainTabBarController.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 19.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    lazy var feedTabBar: UINavigationController = {
        var nc = UINavigationController()
        let feedVC = FeedViewController()
        nc.viewControllers = [feedVC]
        let title = "Feed"
        let image = UIImage(named: "house")
        nc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return nc
    }()

    lazy var profileTabBar: UINavigationController = {
        var nc = UINavigationController()
        let loginVC = LoginViewController(nibName: nil, bundle: nil)
        nc.viewControllers = [loginVC]
        let title = "Profile"
        let image = UIImage(named: "person")
        nc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return nc
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [feedTabBar, profileTabBar]
    }
    

}
