//
//  QRCode+Sort.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 21.05.2022.
//

import Foundation

extension QRCode {
    static let defaultSort = [
        NSSortDescriptor(
            keyPath: \QRCode.userOrder,
            ascending: true),
        NSSortDescriptor(
            keyPath: \QRCode.title,
            ascending: true)
    ]
}
