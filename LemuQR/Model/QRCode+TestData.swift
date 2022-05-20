//
//  QRCode+TestData.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 15.05.2022.
//

import CoreData
import SwiftUI

/**
 Extension that helps provide test data for `QRCode`
 */
extension QRCode {
    static func generateTestData(in context: NSManagedObjectContext) throws {
        let sampleData = [
            QRCodeValues(type: QRCodeType.QR, icon: "person.fill", color: Color.blue, title: "Personal website", content: "https://martykan.github.io/"),
            QRCodeValues(type: QRCodeType.QR, icon: "phone.fill", color: Color.green, title: "Phone number", content: "tel:776436447"),
            QRCodeValues(type: QRCodeType.QR, icon: "allergens", color: Color.red, title: "COVID pass", content: "HC1:NCFOXN%TS3DH3ZSUZK+.V0ETD%65NL-AH%TAIOOP-IMEBQFG4G5HM8CJ0ZMIN9HNO4*J8OX4W$C2VL*LA 43/IE%TE6UG+ZEAT1HQ13W1:O1YUI%F1PN1/T1J$HTR9/O14SI.J9DYHZROVZ05QNZ 20OP748$NI4L6-O16VH6ZL4XP:N6ON1 *L:O8PN1QP5O PLU9A/RUX96 B0V1ZZB.T12.H.ZJ$%HN 9GTBIQ1EK0ZIEQKERQ8IY1I$HH%U8 9PS5OH6*ZUFXFE.R:YN/P3JRH8LHGL2-LH/CJTK96L6SR9MU9DV5 R1:PI/E2$4J6AL.+I9UV6$0+BNPHNBC7CTR3$VDY0DUFRLN/Y0Y/K9/IIF0%:K6*K$X4FUTD14//E3:FL.B$JDBLEH-BL1H6TK-CI:ULOPD6LF20HFJC3DAYJDPKDUDBQEAJJKHHGEC8ZI9$JAQJKZ%K+EPM+8172OJISORYYJL+PZ$MUZ9%K9TPB5FO8CKQ1R3BTA8396M:H638T2LSVLNC3U0O5X.T3 8/X7YAOZRM DC7*M.9OF*TE%RA6UD%B2RKQ*S/10.W3V2"),
            QRCodeValues(type: QRCodeType.QR, icon: "creditcard.fill", color: Color.mint, title: "Bank account", content: "SPD*1.0*ACC:CZ8222500000000103898669"),
            QRCodeValues(type: QRCodeType.QR, icon: "bitcoinsign.circle", color: Color.orange, title: "Bitcoin wallet", content: "16bKPvhvfWCL8peHqKMEgzvxUF7bWtAAFm"),
            QRCodeValues(type: QRCodeType.AZTEC, icon: "tram.fill", color: Color.blue, title: "Czech Railway ticket", content: "#UT012345679012345679012345679012345679"),
            QRCodeValues(type: QRCodeType.PDF417, icon: "airplane", color: Color.purple, title: "Plane boarding pass", content: "M1MARTYKAN/TOMAS       ABCDFG PRGBGYFR 4945 000Y000D0000 123>1234W 1234BFR 0000000000000000000000000000 0                          N"),
            QRCodeValues(type: QRCodeType.CODE128, icon: "qrcode", color: Color.blue, title: "IKEA store card", content: "0123456789"),
        ]
        for sampleCode in sampleData {
            let code = QRCode(context: context)
            code.type = sampleCode.type.rawValue
            code.icon = sampleCode.icon
            code.color = sampleCode.color.encode()
            code.title = sampleCode.title
            code.content = sampleCode.content
            code.contentImage = code.getCodeImageData()
        }
        try context.save()
    }
}
