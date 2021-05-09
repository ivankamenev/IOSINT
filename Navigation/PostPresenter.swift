//
//  PostPresenter.swift
//  Navigation
//
//  Created by Ivan Kamenev on 06.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class PostPresenter: FeedViewOutput {
    var coordinator: FeedCoordinator?
        
    func showPost() {
        coordinator?.showPost()
    }
}
