//
//  IntentHandler.swift
//  LemuQR Intents
//
//  Created by Tomáš Martykán on 20.05.2022.
//

import CoreData
import Intents

class IntentHandler: INExtension, SelectQROptionIntentHandling {
    func provideSelectedQROptionsCollection(for intent: SelectQROptionIntent) async throws -> INObjectCollection<QROptionType> {
        // Fetch codes
        let coreDataContext = CoreDataManager.instance.persistentContainer.viewContext
        let request = QRCode.fetchRequest()
        request.sortDescriptors = QRCode.defaultSort
        let result = try coreDataContext.fetch(request)
        
        // Create an array with the codes
        let options = result.map { code -> QROptionType in
            let option = QROptionType(identifier: code.title, display: code.title!)
            option.name = code.title
            option.imageData = code.contentImage?.base64EncodedString()
            return option
        }
        
        // Create a collection with the array
        let collection = INObjectCollection(items: options)
        return collection
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
