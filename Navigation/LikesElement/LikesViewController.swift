//
//  LikesViewController.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 29.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LikesViewController: UIViewController {

    private let stack: CoreDataStack
    var coordinator: ProfileCoordinator?
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var tasks: [PostEntity] = []
    private let likesCellID = String(describing: LikesTableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        reloadTasks()
    }

    init(stack: CoreDataStack) {
        self.stack = stack
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        view.addSubview(tableView)

        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            LikesTableViewCell.self,
            forCellReuseIdentifier: String(describing: likesCellID)
        )
    }

    private func reloadTasks() {
        tasks = stack.fetchTasks()
        tableView.reloadData()
    }

}

extension LikesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LikesTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: likesCellID), for: indexPath) as! LikesTableViewCell
        cell.post = tasks[indexPath.row]
        return cell
    }
}

extension LikesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, callback) in
            guard let self = self else { return }

            let task = self.tasks.remove(at: indexPath.row)
            self.tableView.performBatchUpdates {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            } completion: { (_) in
                self.stack.remove(task: task)
            }

            callback(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
