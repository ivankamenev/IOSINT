//
//  Coordinator.swift
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
