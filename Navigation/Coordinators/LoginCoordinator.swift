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

    var viewController: UIViewController
    var navigationController: UINavigationController?

    init() {
        viewController = LoginViewController()
        viewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), tag: 1)
        navigationController = UINavigationController(rootViewController: viewController)
    }

    func start() {
    }


}
