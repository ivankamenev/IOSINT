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

    var rootViewController: UIViewController
    var navigationController: UINavigationController?

    init(window: UIWindow, vc: UIViewController) {
        rootViewController = vc
        navigationController = rootViewController.navigationController
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func start() {
    }

}
