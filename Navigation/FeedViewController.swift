//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    let post: Post = Post(title: "Пост")
    
    let stackView = UIStackView()
    let button = UIButton()
    let button2 = UIButton()
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        view.backgroundColor = .green
        
        configurateStackView()
        addButtonToStackView(button)
        addButtonToStackView(button2)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerBackgroundTask()
        
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ​endBackgroundTask()
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    func configurateStackView() {
        
        view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        setStackViewConstraints()
    }
    
    func addButtonToStackView(_ button: UIButton) {
        
            button.clipsToBounds = true
            button.layer.cornerRadius = button.frame.size.width/25
            button.setTitle("InfoVC", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tapedButton(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        
    }
    
    @objc func tapedButton(_ button: UIButton) {
        
        present(PostViewController(), animated: true, completion: nil)
        
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
    }
}

extension FeedViewController {
    func registerBackgroundTask() {
        print("Background task started.")
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.​endBackgroundTask()
        }
        assert(backgroundTask != .invalid)
    }

    func ​endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}
