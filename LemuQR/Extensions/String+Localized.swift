//
//  String+Localizable.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import Foundation

/**
 String localization utility extension
 */
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
