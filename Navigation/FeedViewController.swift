//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

protocol FeedViewOutput {
    func showPost(_:Post)
    var navigationController: UINavigationController? { get set }
}

    class FeedViewController: UIViewController {

        var output: FeedViewOutput?

        lazy var containerView: UIView = {
            let container = ContainerView()
            container.onTap = output?.showPost(_:)
            return container
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .green
            output = PostPresenter()
            output?.navigationController = navigationController
            view.addSubview(containerView)
            setupConstraints()
            print(type(of: self), #function)

        }
        
        func setupConstraints() {
            containerView.snp.makeConstraints() { make in
                make.top.leading.bottom.trailing.equalToSuperview()
            }
        }

    }
    class ContainerView: UIView {

        let post: Post = Post(title: "Post")

        var onTap: ((Post) -> Void)?

        let oneButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("PostVC", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemRed
            button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
            return button
        }()
        
        let twoButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("PostVC", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemRed
            button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
            return button
        }()

        lazy var buttonsStack: UIStackView = {
            let buttonsStack = UIStackView()
            buttonsStack.addArrangedSubview(oneButton)
            buttonsStack.addArrangedSubview(twoButton)
            buttonsStack.alignment = .fill
            buttonsStack.distribution = .fillEqually
            buttonsStack.axis = .horizontal
            buttonsStack.spacing = 10
            buttonsStack.layer.masksToBounds = true
            return buttonsStack
        }()

        func newConstraints() {
                buttonsStack.snp.makeConstraints() { make in
                    make.leading.equalToSuperview().offset(16)
                    make.trailing.equalToSuperview().inset(16)
                    make.centerY.equalToSuperview()
                }
            }

        @objc private func buttonTap() {
            guard onTap != nil else { return }
            onTap!(post)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(buttonsStack)
            newConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

        class PostPresenter: FeedViewOutput {
            func showPost(_ post: Post) {
                   let postViewController = PostViewController()
                   postViewController.post = post
                   navigationController?.pushViewController(postViewController, animated: true)
               }
            var navigationController: UINavigationController?

            }
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
