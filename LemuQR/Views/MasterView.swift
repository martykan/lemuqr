//
//  MasterView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import SwiftUI

struct MasterView: View {
    @EnvironmentObject var viewModel: QRCodesViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedItem: QRCode? = nil
    @FetchRequest(
        sortDescriptors: []
    ) private var fetchResult: FetchedResults<QRCode>
    
    @State var navigateTo: AnyView?
    @State var isNavigationActive = false

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
                                .colorInvert()
                        }
                        Text(item.title ?? "")
                    }
                }
            }
            .onDelete { offsets in
                viewModel.removeCode(object: fetchResult[offsets.first!], in: viewContext)
            }
        }
        .listStyle(.sidebar)
        .navigationBarTitle("LemuQR")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Button(action: {
                        self.navigateTo = AnyView(EditItemView())
                        self.isNavigationActive = true
                    }) {
                        Label("Create".localized, systemImage: "plus.app")
                    }
                    Button(action: {}) {
                        Label("Scan with Camera".localized, systemImage: "camera")
                    }
                    Button(action: {}) {
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
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView().environmentObject(QRCodesViewModel())
    }
}
