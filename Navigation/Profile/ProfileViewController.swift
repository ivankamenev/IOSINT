//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ivan Kamenev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private let stack: CoreDataStack
    
    var coordinator: ProfileCoordinator?
    let posts = [Post(author: "Joaquin Phoenix",
                      description: "I'm new Joker",
                      image: "image 1",
                      likes: 100500,
                      views: 124567),
                 Post(author: "Keanu Reeves",
                      description: "I'm John Wick",
                      image: "image 2",
                      likes: 1276543,
                      views: 8765433),
                 Post(author: "Sam",
                      description: "1+1.Good Film",
                      image: "image 3",
                      likes: 987654,
                      views: 1224566),
                 Post(author: "HellBoy",
                      description: "Welcome to hell",
                      image: "image 4",
                      likes: 666,
                      views: 1245698765)
    ]
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let background = UIView()
    private let close = UIButton()
    private lazy var header = ProfileHeaderView()
    private lazy var tableHeader = ProfileTableHederView()
    private lazy var image = UIImageView()
    
    init(stack: CoreDataStack) {
        self.stack = stack
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.layer.cornerRadius = 24/2
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(exitButton)
        view.backgroundColor = .white
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            exitButton.widthAnchor.constraint(equalToConstant: 24),
            exitButton.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: String(describing: PostTableViewCell.self)
        )
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(
            ProfileTableHederView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHederView.self)
        )
    }
    
    @objc private func exitButtonPressed() {
        try! Auth.auth().signOut()
        coordinator?.closeButtonPressed()
    }

    
    @objc func avatarTap(gestureRecognizer: UITapGestureRecognizer) {
        print("tapped")
        self.close.layer.opacity = 0
        
        isAnimating = true
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
//                if let image = gestureRecognizer.view! as? UIImageView {
                    self.background.backgroundColor = .black
                    self.background.layer.opacity = 0.5
                    self.background.translatesAutoresizingMaskIntoConstraints = false
                    self.image.translatesAutoresizingMaskIntoConstraints = false

                    self.view.addSubview(self.background)
                    self.view.addSubview(self.image)
       

                    let constraints = [
                        self.background.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                        self.background.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                        self.background.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                        self.background.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),

                        self.image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                        self.image.heightAnchor.constraint(equalTo: self.image.widthAnchor),
                        self.image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                        self.image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    ]

                    NSLayoutConstraint.activate(constraints)
                    self.image.layoutIfNeeded()
//                }
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                let closeImage = UIImage(systemName: "clear")
                self.close.translatesAutoresizingMaskIntoConstraints = false
                self.close.setImage(closeImage, for: [])
                
                self.background.addSubview(self.close)
                
                let constraints = [
                    self.close.topAnchor.constraint(equalTo: self.background.topAnchor),
                    self.close.trailingAnchor.constraint(equalTo: self.background.trailingAnchor),
                    self.close.widthAnchor.constraint(equalToConstant: 50),
                    self.close.heightAnchor.constraint(equalToConstant: 50)
                ]

                NSLayoutConstraint.activate(constraints)

                self.close.layer.opacity = 1
            }
        }, completion: { finished in
            isAnimating = false
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeTap))
            self.close.addGestureRecognizer(recognizer)
        })
    }
    
    @objc func closeTap(gestureRecognizer: UITapGestureRecognizer) {
        print("tapped")
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.background.layer.opacity = 0
                self.header.layoutSubviews()
            }
        }, completion: { finished in
            self.image.removeFromSuperview()
            self.tableHeader.setupViews()
            self.background.removeFromSuperview()
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.avatarTap))
            self.tableHeader.profileHeaderView.imageView.addGestureRecognizer(recognizer)
        })
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.post = posts[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Footer for section: \(section)"
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        } else {
            return .zero
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHederView.self)) as! ProfileTableHederView
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTap))
            headerView.profileHeaderView.imageView.addGestureRecognizer(recognizer)
            self.header = headerView.profileHeaderView
            self.image = headerView.profileHeaderView.imageView
            self.tableHeader = headerView
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            coordinator?.photosSelected()
        }
    }

}


extension ProfileViewController: PostTableCellDelegate {
    func savePost(post: Post) {
        stack.createNewTask(author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views)
    }
}

protocol PostTableCellDelegate: AnyObject {
    func savePost(post: Post)
}
