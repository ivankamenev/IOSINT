//
//  Coordinator.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 01.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    
    var viewController: UIViewController {get set}
    var navigationController: UINavigationController? {get set}
    
    func start()
}
