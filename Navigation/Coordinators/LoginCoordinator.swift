//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 01.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {

    var rootViewController: UIViewController
    var navigationController: UINavigationController?

    init() {
        let vc = LoginViewController()
        rootViewController = vc
        rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), tag: 1)
        navigationController = UINavigationController(rootViewController: rootViewController)
        vc.coordinator = self
    }

    func start() {
    }
    
    func startFeed() {
        navigationController?.show(ProfileViewController(), sender: nil)
    }


}
