//
//  LikesViewController.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 29.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import CoreData

class LikesViewController: UIViewController {
    
    private let stack: CoreDataStack
    var coordinator: ProfileCoordinator?
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var tasks: [PostEntity] = []
    private let likesCellID = String(describing: LikesTableViewCell.self)
    private var isInitiallyLoaded: Bool = false

    private lazy var fetchResultsController: NSFetchedResultsController<PostEntity> = {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        let controller = NSFetchedResultsController(
        fetchRequest: request,
        managedObjectContext: stack.viewContext,
        sectionNameKeyPath: nil,
        cacheName: nil
       )
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isInitiallyLoaded {
            isInitiallyLoaded = true
            stack.viewContext.perform {
                self.performFetch()
            }
        }
    }
    
    init(stack: CoreDataStack) {
        self.stack = stack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showPopup))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearSearch))
        
        navigationItem.rightBarButtonItems = [search, refresh]
        
        
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
        fetchResultsController.fetchRequest.predicate = nil
        performFetch()
    }
    
    private func reloadTasksWithPredicate(predicate: String) {
        let predicate = NSPredicate(format: "%K LIKE %@", #keyPath(PostEntity.author), predicate)
        fetchResultsController.fetchRequest.predicate = predicate
        performFetch()
    }

    private func performFetch() {
        do {
            try self.fetchResultsController.performFetch()
            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    @objc private func showPopup() {
        let alert = UIAlertController(title: "Поиск по автору", message: "Введите имя автора", preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            let textField = alert!.textFields![0]
            self.reloadTasksWithPredicate(predicate: textField.text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func clearSearch() {
        reloadTasks()
    }
}

extension LikesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LikesTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: likesCellID), for: indexPath) as! LikesTableViewCell
        cell.post = fetchResultsController.object(at: indexPath)
        return cell
    }
}

extension LikesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, callback) in
            guard let self = self else { return }
            
            let post = self.fetchResultsController.object(at: indexPath)
            self.stack.remove(post: post)
            
            callback(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension LikesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        tableView.beginUpdates()
    }

    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        switch type {
            case .delete:
                guard let indexPath = indexPath else { fallthrough }

                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .insert:
                guard let newIndexPath = newIndexPath else { fallthrough }

                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .move:
                guard
                    let indexPath = indexPath,
                    let newIndexPath = newIndexPath
                else { fallthrough }

                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath = indexPath else { fallthrough }

                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                fatalError()
        }
    }

    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        tableView.endUpdates()
    }
}
