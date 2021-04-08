//
//  MainCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 01.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCoordinator: class {
    var childCoordinators: [ChildCoordinator] { get set }
    var tabBarController: UITabBarController { get set }

    func start()
}

protocol ChildCoordinator: class {
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: BaseCoordinator {
    var tabBarController: UITabBarController
    var childCoordinators: [ChildCoordinator]

    init(tabBarController: UITabBarController, childCoordinators: [ChildCoordinator] = []) {
        self.tabBarController = tabBarController
        self.childCoordinators = childCoordinators
    }

    func start() {
        var navigationControllers = [UINavigationController]()
        for coordinator in childCoordinators {
            navigationControllers.append(coordinator.navigationController)
            coordinator.start()
        }

        tabBarController.viewControllers = navigationControllers
    }
}
