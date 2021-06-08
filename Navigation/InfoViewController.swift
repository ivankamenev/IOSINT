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
    let urlString = "https://jsonplaceholder.typicode.com/todos/42"
    let planetString = "https://swapi.dev/api/planets/5"
    
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
    
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        getData()
    }
    
    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(showAlertButton)
        view.addSubview(infoLabel)
        view.addSubview(planetLabel)
        
        let constraints = [
            showAlertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            showAlertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            showAlertButton.widthAnchor.constraint(equalToConstant: 150),
            showAlertButton.heightAnchor.constraint(equalToConstant: 50),
            
            infoLabel.topAnchor.constraint(equalTo: showAlertButton.bottomAnchor, constant: 15),
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 50),

            planetLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 15),
            planetLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            planetLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            planetLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func showAlert(_ sender: Any) {
        coordinator?.showAlert()
    }
    
    private func getData() {
            let titleUrl = URL(string: urlString)
            let planetURL = URL(string: planetString)
            NetworkService.infoDataTask(url: titleUrl!, block: printInLabel)
            NetworkService.infoDataTask(url: planetURL!, block: printInPlanetLabel)
        }

        private func printInLabel(json: Data) {
            if let result = try? JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String: Any] {
                infoLabel.text = result["title"] as? String
            }
        }

        private func printInPlanetLabel(json: Data) {
            if let resultL = String(data: json, encoding: .utf8) {
                print("RESULTL: \(resultL)")
            }

            if let result = try? JSONDecoder().decode(Planet.self, from: json) {
                print("result: \(result)")
                planetLabel.text = result.orbitalPeriod
            } else {
                print("BAD RESULT")
            }
        }
}
