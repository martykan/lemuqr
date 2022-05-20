//
//  QRCodeType.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import Foundation

/**
 Code types that are supported
 */
@objc
enum QRCodeType : Int32 {
    case QR
    case DATAMATRIX
    case AZTEC
    case PDF417
    case CODE128
}
