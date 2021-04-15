//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 15.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?
    var infoVC: InfoViewController?

    init(navigationController: UINavigationController, tabBarController: UITabBarController?) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func showPost() {
        let controller = PostViewController()
        controller.post = Post(title: "Post")
        controller.coordinator = self
        navigationController?.pushViewController(controller, animated: true)
    }

    func presentPost() {
        infoVC = InfoViewController()
        infoVC?.coordinator = self
        navigationController?.present(infoVC!, animated: true)
    }

    func showAlert() {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        infoVC?.present(alertController, animated: true, completion: nil)
    }
}
