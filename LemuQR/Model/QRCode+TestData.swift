//
//  QRCode+TestData.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 15.05.2022.
//

import CoreData
import SwiftUI

extension QRCode {
    static func generateTestData(in context: NSManagedObjectContext) throws {
        for id in 0..<10 {
            let code = QRCode(context: context)
            code.type = QRCodeType.QR.rawValue
            code.title = "Code \(id)"
            code.content = "code\(id)"
            code.contentImage = code.getCodeImageData()
            code.icon = "qrcode"
            code.color = Color.black.encode()
        }
        try context.save()
    }
}
