//
//  MainCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 01.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator  {

    var viewController: UIViewController = MainTabBarController()
    var navigationController: UINavigationController?

    init(window: UIWindow) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    func start() {
    }

}
