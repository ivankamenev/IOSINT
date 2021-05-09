//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ivan Kamenev on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    
    private lazy var showAlertButton: UIButton = {
        let button = UIButton()
        button.setTitle("show alert", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(showAlertButton)
        
        let constraints = [
            showAlertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            showAlertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            showAlertButton.widthAnchor.constraint(equalToConstant: 150),
            showAlertButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func showAlert(_ sender: Any) {
        coordinator?.showAlert()
    }
}
