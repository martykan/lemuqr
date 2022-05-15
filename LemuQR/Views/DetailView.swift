//
//  MasterView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import UIKit
import SwiftUI
import CoreData

struct DetailView: View {
    @EnvironmentObject private var viewModel: QRCodesViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String?
    @State private var imageData: Data?
    @State private var previousBrightness: CGFloat?

    var objectId: NSManagedObjectID?
    
    var body: some View {
        return VStack() {
            if objectId != nil, let _imageData = imageData {
                Image(uiImage: UIImage(data: _imageData)!)
                    .resizable()
                    .frame(width: 200, height: 200)
                Text(title ?? "")
            } else {
                Text("No selection".localized)
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditItemView(objectId: objectId)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }.onAppear {
            self.previousBrightness = UIScreen.main.brightness
            UIScreen.main.brightness = CGFloat(1.0)
            
            guard let _objectId = objectId, let _code = viewModel.fetchCode(for: _objectId, context: viewContext) else {
                return
            }
            self.title = _code.title
            self.imageData = _code.getCodeImageData()
        }
        .onDisappear {
            if let _previousBrightness = previousBrightness {
                UIScreen.main.brightness = _previousBrightness
            }
        }
    }
}

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
