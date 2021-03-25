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
    
