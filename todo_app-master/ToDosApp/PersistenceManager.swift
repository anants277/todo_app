//
//  PersistenceManager.swift
//  ToDosApp
//
//  Created by Creo Server on 20/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager
{
    private init(){}
    //making it singleton
    static let shared = PersistenceManager()
    //making the context
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "ToDosApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError?
            {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do
            {
                try context.save()
                print(context)
                print("Saved Successfully")
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
