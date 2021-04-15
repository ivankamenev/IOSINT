//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 15.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import UIKit

class ProfileCoordinator: FlowCoordinator {
    lazy var loginInspector = LoginValidator()

    var navigationController: UINavigationController
    weak var mainCoordinator: AppCoordinator?

    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }

    func start() {
        let vc = LoginViewController(nibName: nil, bundle: nil)
        vc.authorizationDelegate = loginInspector
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func backtoRoot() {
        // Guard of action's body
        guard navigationController.viewControllers.count > 0 else { return }
        // Go to root controller
        navigationController.popToRootViewController(animated: true)
    }

    func gotoProfile() {
        let vc = ProfileViewController()
        vc.flowCoordinator = self
        // Hide navigation bar
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: true)
    }

    func gotoPhotos() {
        let vc = PhotosViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
