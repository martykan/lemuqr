//
//  QRCodeType.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import Foundation
import SwiftUI

/**
 Describes values that are stored in `QRCode`
 */
struct QRCodeValues {
    let type: QRCodeType
    let icon: String
    let color: Color
    let title: String
    let content: String
}
