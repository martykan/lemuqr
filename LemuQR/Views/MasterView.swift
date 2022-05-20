//
//  MasterView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import SwiftUI
import CodeScanner

/**
 View showing the list of codes
 */
struct MasterView: View {
    @EnvironmentObject var viewModel: QRCodesViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedItem: QRCode? = nil
    @FetchRequest(
        sortDescriptors: QRCode.defaultSort
    ) private var fetchResult: FetchedResults<QRCode>
    
    @State var navigateTo: AnyView?
    @State var isNavigationActive = false
    @State private var isShowingScanner = false
    @State private var isShowingGallery = false

    var body: some View {
        List {
            ForEach(fetchResult, id: \.self) { item in
                NavigationLink(destination: DetailView(objectId: selectedItem?.objectID), tag: item, selection: $selectedItem) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.decode(item.color))
                                .frame(width: 30, height: 30)
                            Image(systemName: item.icon ?? "qrcode")
                                .foregroundColor(Color.white)
                        }
                        Text(item.title ?? "")
                    }
                }
            }
            .onDelete { offsets in
                viewModel.removeCode(object: fetchResult[offsets.first!], in: viewContext)
            }
            .onMove(perform: { source, destination in
                var reorderedItems: [QRCode] = fetchResult.map{ $0 }
                reorderedItems.move(fromOffsets: source, toOffset: destination )
                for reverseIndex in stride(from: reorderedItems.count - 1, through: 0, by: -1) {
                    reorderedItems[reverseIndex].userOrder = Int32(reverseIndex)
                }
                try? viewContext.save()
            })
        }
        .listStyle(.sidebar)
        .navigationBarTitle("LemuQR")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Button(action: {
                        self.navigateTo = AnyView(EditItemView())
                        self.isNavigationActive = true
                    }) {
                        Label("Create".localized, systemImage: "plus.app")
                    }
                    Button(action: {
                        isShowingScanner = true
                    }) {
                        Label("Scan with Camera".localized, systemImage: "camera")
                    }
                    Button(action: {
                        isShowingScanner = true
                        isShowingGallery = true
                    }) {
                        Label("Import from Image".localized, systemImage: "photo.on.rectangle")
                    }
                }) {
                    Image(systemName: "plus").imageScale(.large)
                }
            }
        }
        .background(
            NavigationLink(destination: self.navigateTo, isActive: $isNavigationActive) {
                EmptyView()
            }
        )
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr, .dataMatrix, .aztec, .pdf417, .code128], simulatedData: "LemuQR", isGalleryPresented: $isShowingGallery, completion: handleScan)
        }
    }
    
    func handleScan(res: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        isShowingGallery = false
        if let scannedCode = try? res.get() {
            let values = QRCodeValues(
                type: QRCodeType.from(avType: scannedCode.type),
                icon: "qrcode",
                color: Color.black,
                title: String(scannedCode.string.prefix(50)),
                content: scannedCode.string
            )
            viewModel.saveCode(
                objectId: nil,
                with: values,
                in: viewContext)
        }
    }
}

// MARK: Previews
struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView().environmentObject(QRCodesViewModel())
    }
}
