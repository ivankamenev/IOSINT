//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 01.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

protocol FeedFlowCoordinator: ChildCoordinator {
    func showPostVC(post: Post)
}

class FeedCoordinator: FeedFlowCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        feedViewController.tabBarItem = TabBarModel.items[.feed]

        navigationController.pushViewController(feedViewController, animated: false)
    }

    func showPostVC(post: Post) {
        let postViewController = PostViewController()
        postViewController.coordinator = self
        postViewController.post = post

        navigationController.pushViewController(postViewController, animated: true)
    }
}
