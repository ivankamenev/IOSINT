//
//  MainTabBarController.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 19.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    let feed = FeedCoordinator()
    let login = LoginCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [feed.navigationController!, login.navigationController!]

    }
}
