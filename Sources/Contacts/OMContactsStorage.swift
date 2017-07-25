//
//  OMContactsStorage.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit
import CoreData

private let kOMContactEntityName = "OMContact"

public class OMContactsStorage: NSObject {
    public static let sharedStorage = OMContactsStorage()
    public func saveContactWith(firstName: String, lastName: String, phoneNumber: String, StreetAddress1: String, StreetAddress2: String, city: String, state: String, zipCode: String) {
        let contact = NSEntityDescription.insertNewObject(forEntityName: kOMContactEntityName, into: persistentContainer.viewContext) as! OMContact
        let contactID = String(mutableContacts.count + 1)
        contact.contactID = contactID
        contact.firstName = firstName
        contact.lastName = lastName
        contact.phoneNumber = phoneNumber
        contact.streetAddress1 = StreetAddress1
        contact.streetAddress2 = StreetAddress2
        contact.state = state
        contact.city = city
        contact.zipCode = zipCode
        
        saveContext()
        
        let localContact = OMLocalContact()
        localContact.contactID = contactID
        localContact.firstName = firstName
        localContact.lastName = lastName
        localContact.phoneNumber = phoneNumber
        localContact.streetAddress1 = StreetAddress1
        localContact.streetAddress2 = StreetAddress2
        localContact.city = city
        localContact.state = state
        localContact.zipCode = zipCode
        
        mutableContacts.append(localContact)
        
    }
    private var mutableContacts = [OMLocalContact]()
    
    public func contacts() -> Array<OMLocalContact> {
        return mutableContacts
    }
    
    public func updateContact(contact: OMLocalContact, firstName: String, lastName: String, phoneNumber: String, StreetAddress1: String, StreetAddress2: String, city: String, state: String, zipCode: String) {
        let index = mutableContacts.index(of: contact)
        let contactsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kOMContactEntityName)
        do {
            if let contacts = try persistentContainer.viewContext.fetch(contactsFetchRequest) as? [OMContact] {
                let contact = contacts[index!]
                contact.firstName = firstName
                contact.lastName = lastName
                contact.phoneNumber = phoneNumber
                contact.streetAddress1 = StreetAddress1
                contact.streetAddress2 = StreetAddress2
                contact.state = state
                contact.city = city
                contact.zipCode = zipCode
                saveContext()
            }
        } catch {
            
        }
        let localContact = mutableContacts[index!]
        localContact.firstName = firstName
        localContact.lastName = lastName
        localContact.phoneNumber = phoneNumber
        localContact.streetAddress1 = StreetAddress1
        localContact.streetAddress2 = StreetAddress2
        localContact.city = city
        localContact.state = state
        localContact.zipCode = zipCode
    }
    
    public func deleteContact(contact: OMLocalContact) {
        let index = mutableContacts.index(of: contact)
        mutableContacts.remove(at: index!)
        let contactsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kOMContactEntityName)
        do {
            if let contacts = try persistentContainer.viewContext.fetch(contactsFetchRequest) as? [OMContact] {
                persistentContainer.viewContext.delete(contacts[index!])
                saveContext()
            }
        } catch {
            
        }
        
    }
    private func loadContacts() {
        let contactsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kOMContactEntityName)
        do {
            if let contacts = try persistentContainer.viewContext.fetch(contactsFetchRequest) as? [OMContact] {
                for contact in contacts {
                    let localContact = OMLocalContact()
                    localContact.contactID = contact.contactID!
                    localContact.firstName = contact.firstName!
                    localContact.lastName = contact.lastName!
                    localContact.phoneNumber = contact.phoneNumber!
                    localContact.streetAddress1 = contact.streetAddress1!
                    localContact.streetAddress2 = contact.streetAddress2!
                    localContact.state = contact.state!
                    localContact.city = contact.city!
                    localContact.zipCode = contact.zipCode!
                    mutableContacts.append(localContact)
                }
            }
        } catch {
            
        }
    }
    
    private override init() {
        super.init()
        loadContacts()
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: .UIApplicationWillTerminate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc private func appWillTerminate() {
        NotificationCenter.default.removeObserver(self)
        print("App will terminate")
        saveContext()
    }
    
    @objc private func appDidEnterBackground() {
        print("app did enter background")
        saveContext()
    }
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
                let container = NSPersistentContainer(name: "Contacts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
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
