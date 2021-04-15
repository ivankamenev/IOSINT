//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 01.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {

    var navigationController: UINavigationController?
    var rootViewController: UIViewController

    init() {

        rootViewController = ProfileViewController()
        rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), tag: 1)
        navigationController = UINavigationController(rootViewController: rootViewController)
    }

    func start() {
    }

}
