//
//  QRCode+Image.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import Foundation
import AVFoundation
#if !os(watchOS)
import RSBarcodes_Swift
#endif

extension QRCode {
    func getCodeImageData() -> Data? {
#if !os(watchOS)
        let codeObjectType: AVMetadataObject.ObjectType
        switch QRCodeType(rawValue: self.type) {
        case .QR:
            codeObjectType = AVMetadataObject.ObjectType.qr
        case .AZTEC:
            codeObjectType = AVMetadataObject.ObjectType.aztec
        case .DATAMATRIX:
            codeObjectType = AVMetadataObject.ObjectType.dataMatrix
        case .CODE128:
            codeObjectType = AVMetadataObject.ObjectType.code128
        case .PDF417:
            codeObjectType = AVMetadataObject.ObjectType.pdf417
        default:
            return nil
        }
        
        let uiImage = RSUnifiedCodeGenerator.shared.generateCode(self.content ?? "", machineReadableCodeObjectType: codeObjectType.rawValue, targetSize: CGSize(width: 200, height: 200))
        let data = uiImage?.pngData()
        self.contentImage = data
        return data
#else
        return nil
#endif
    }
}
