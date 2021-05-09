//
//  PostViewController.swift
//  Navigation
//
//  Created by Ivan Kamenev on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    var post: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = post
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .red
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
    }
    
    @objc private func addTapped() {
        coordinator?.presentPost()
    }
}
