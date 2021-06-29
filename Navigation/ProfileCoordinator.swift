//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Ivan Kamenev on 12.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?
    private let stack: CoreDataStack
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController?, stack: CoreDataStack) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.stack = stack
    }
    
    func loginButtonPressed() {
        let profile = ProfileViewController(stack: stack)
        profile.coordinator = self
        navigationController?.pushViewController(profile, animated: true)
    }
    
    func closeButtonPressed() {
           navigationController?.popViewController(animated: true)
    }
    
    func photosSelected() {
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    func showAlert(error: Errors) {
        func showAlert(error: Errors) {
                var message = ""
                switch error {
                case .incorrectData:
                    message = "Введены неверные данные. Проверьте введённые данные"
                case .shortPassword:
                    message = "Пароль должен содержать минимум 6 символов"
                case .incorrectEmail:
                    message = "Логин не соответсвует адресу почты"
                }

                let alertController = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    print("OK")
                }
        }
    }
}
