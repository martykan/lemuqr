//
//  MasterView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var code: QRCode?
    
    var body: some View {
        VStack() {
            if code != nil, let _imageData = code?.contentImage {
                ZStack {
                    Image(uiImage: UIImage(data: _imageData)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            } else {
                Text("No selection".localized)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(code: getItem())
    }
    
    static func getItem() -> QRCode {
        let context = CoreDataManager(inMemory: true).persistentContainer.viewContext
        let qrCode = QRCode(context: context)
        qrCode.icon = "qrcode"
        qrCode.title = "Title of Code"
        qrCode.content = "content..."
        return qrCode
    }
}
