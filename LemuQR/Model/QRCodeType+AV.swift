//
//  QRCodeType.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import Foundation
import AVFoundation

/**
 Extension to convert from AVFoundation types
 */
extension QRCodeType {
    static func from(avType: AVMetadataObject.ObjectType) -> QRCodeType {
        let type: QRCodeType
        switch avType {
        case .dataMatrix:
            type = .DATAMATRIX
        case .aztec:
            type = .AZTEC
        case .pdf417:
            type = .PDF417
        case .code128:
            type = .CODE128
        default:
            type = .QR
        }
        return type
    }
}
