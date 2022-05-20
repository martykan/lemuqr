//
//  CoreDataManager.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 15.05.2022.
//

import CoreData

/**
 Class holding CoreData container
 */
class CoreDataManager {
    static let instance = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentCloudKitContainer(name: "DataModel")
        if inMemory,
           let storeDescription = persistentContainer.persistentStoreDescriptions.first {
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.test.lemuqr")!
            let storeURL = containerURL.appendingPathComponent("DataModel.sqlite")
            let storeDescription = persistentContainer.persistentStoreDescriptions.first
            storeDescription?.url = storeURL
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
            }
        }
    }
}
