//
//  OMContactsStorage.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit
import CoreData

public class OMContactsStorage: NSObject {
    public static let sharedStorage = OMContactsStorage()
    private override init() {
        super.init()
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
                let container = NSPersistentContainer(name: "Contacts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
