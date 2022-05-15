//
//  Color+Encode.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import SwiftUI

/**
 Enables us to store SwiftUI Color as data in CoreData
 */
extension Color {
    static func decode(_ data: Data?) -> Color {
        guard
            let _data = data,
            let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(_data) as? UIColor
        else {
            return .black
        }
        return Color(uiColor)
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false)
    }
}
