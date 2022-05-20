//
//  QRCodesViewModel.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import Foundation
import CoreData

/**
 ViewModel containing `QRCode` operations
 */
class QRCodesViewModel : ObservableObject {
    /**
    Fetch a QR code by it's ID
    - Parameter objectId the ID of the code being loaded
    - Parameter in CoreData context
    */
    func fetchCode(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> QRCode? {
        guard let code = context.object(with: objectId) as? QRCode else {
            return nil
        }
        return code
    }
    
    /**
    Create or edit a QR code.
    - Parameter objectId the ID of the code being edited, if nil creates a new one
    - Parameter with values to save
    - Parameter in CoreData context
    */
    func saveCode(
        objectId: NSManagedObjectID?,
        with values: QRCodeValues,
        in context: NSManagedObjectContext
    ) {
        let code: QRCode
        if let _objectId = objectId,
           let fetchedFriend = fetchCode(for: _objectId, context: context) {
            code = fetchedFriend
        } else {
            code = QRCode(context: context)
        }
        
        code.type = values.type.rawValue
        code.icon = values.icon
        code.color = values.color.encode()
        code.title = values.title
        code.content = values.content
        code.contentImage = code.getCodeImageData()
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
    
    /**
    Remove a QR code by it's ID
    - Parameter objectId the ID of the code being removed
    - Parameter in CoreData context
    */
    func removeCode(object: NSManagedObject,
                    in context: NSManagedObjectContext) {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
