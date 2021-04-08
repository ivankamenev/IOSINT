//
//  TabBarModel.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 08.04.2021.
//  Copyright © 2021 Ivan Kamenev. All rights reserved.
//

import Foundation
import UIKit

enum TabBarModel: String {
    case profile = "Profile"
    case feed = "Feed"

    static let items = [
        TabBarModel.profile: UITabBarItem(title: TabBarModel.profile.rawValue, image: #imageLiteral(resourceName: "user"), selectedImage: #imageLiteral(resourceName: "user")),
        TabBarModel.feed: UITabBarItem(title: TabBarModel.feed.rawValue, image: #imageLiteral(resourceName: "home-page"), selectedImage: #imageLiteral(resourceName: "home-page"))
    ]
}
