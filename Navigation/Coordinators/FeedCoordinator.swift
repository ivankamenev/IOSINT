//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 01.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var rootViewController: UIViewController

    init() {
        rootViewController = FeedViewController()
        rootViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "house"), tag: 0)
        navigationController = UINavigationController(rootViewController: rootViewController)
    }

    func start() {
    }

}
