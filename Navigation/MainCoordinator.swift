//
//  MainCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 15.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import UIKit

protocol MainCoordinator {
    var tabBarController: UITabBarController { get set }
    var flowCoordinators: [FlowCoordinator] { get set }

    func start()
}
