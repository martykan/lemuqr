//
//  MasterView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import UIKit
import SwiftUI
import CoreData

/**
 Screen showing the detail of a code
 */
struct DetailView: View {
    @EnvironmentObject private var viewModel: QRCodesViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String?
    @State private var imageData: Data?

    var objectId: NSManagedObjectID?
    
    var body: some View {
        return VStack() {
            if objectId != nil, let _imageData = imageData {
                Image(uiImage: UIImage(data: _imageData)!)
                    .resizable()
                    .scaledToFit()
                Text(title ?? "")
            } else {
                Text("No selection".localized)
            }
        }
        .padding(30)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditItemView(objectId: objectId)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }.onAppear {
            guard let _objectId = objectId, let _code = viewModel.fetchCode(for: _objectId, context: viewContext) else {
                return
            }
            self.title = _code.title
            self.imageData = _code.getCodeImageData()
        }
    }
}

// MARK: Previews
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(objectId: getItem().objectID)
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
