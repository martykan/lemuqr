//
//  CoreDataManager.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 15.05.2022.
//

import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentCloudKitContainer(name: "DataModel")
        if inMemory,
           let storeDescription = persistentContainer.persistentStoreDescriptions.first {
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
            }
        }
    }
    
    static var preview: CoreDataManager = {
        let result = CoreDataManager(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        try! QRCode.generateTestData(in: viewContext)
        return result
    }()
}
