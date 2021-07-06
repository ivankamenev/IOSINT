//
//  CoreDataStack.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 28.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import CoreData

class CoreDataStack {
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func fetchTasks() -> [PostEntity] {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("🤷‍♂️ Что-то пошло не так..")
        }
    }
    
    func fetchTasksWithPredicate(value: String) -> [PostEntity] {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        let predicate = NSPredicate(format: "%K LIKE %@", #keyPath(PostEntity.author), value)
        request.predicate = predicate
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("🤷‍♂️ Что-то пошло не так..")
        }
    }


    
    func remove(task: PostEntity) {
        viewContext.delete(task)
        
        save(context: viewContext)
    }
    
    func createNewTask(author: String, description: String, image: String, likes: Int, views: Int) {
        let context = newBackgroundContext()
        let newPost = PostEntity(context: context)
        newPost.id = UUID()
        newPost.author = author
        newPost.descript = description
        newPost.image = image
        newPost.likes = Int64(likes)
        newPost.views = Int64(views)
        
        save(context: context)
    }
    
    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
