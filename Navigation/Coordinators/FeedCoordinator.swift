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
    var viewController: UIViewController

    init() {
        viewController = FeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "house"), tag: 0)
        navigationController = UINavigationController(rootViewController: viewController)
    }

    func start() {
    }

}
