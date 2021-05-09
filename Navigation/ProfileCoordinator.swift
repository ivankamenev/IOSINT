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
    
    func showAlert(error: Errors) {
        var alertMessage = ""
        
        switch error {
        case .loginIsEmpty:
            alertMessage = "Введите логин"
        case .passIsEmpty:
            alertMessage = "Введите пароль"
        case .incorrectLogin:
            alertMessage = "Введён неверный логин"
        case .incorrectPass:
            alertMessage = "Введён неверный пароль"
        }
        
        let alertController = UIAlertController(title: "Ошибка!", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        }
        alertController.addAction(okAction)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
}
