//
//  QRCodesViewModel.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import Foundation
import CoreData

class QRCodesViewModel : ObservableObject {
    func fetchCode(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> QRCode? {
        guard let code = context.object(with: objectId) as? QRCode else {
            return nil
        }
        return code
    }
    
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
    
    func removeCode(object: NSManagedObject,
                    in context: NSManagedObjectContext) {
        context.delete(object)
    }
}
