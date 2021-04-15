//
//  FlowCoordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 15.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import UIKit

protocol FlowCoordinator {
    var mainCoordinator: AppCoordinator? { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func backtoRoot()
}
