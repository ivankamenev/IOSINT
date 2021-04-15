//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 15.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var tabBarController: UITabBarController? { get set }
    var navigationController: UINavigationController? { get set }
}

class ProfileCoordinator: Coordinator  {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController, tabBarController: UITabBarController?) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func loginButtonPressed() {
        let profile = ProfileViewController()
        profile.coordinator = self
        navigationController?.pushViewController(profile, animated: true)
    }

    func photosSelected() {
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}
