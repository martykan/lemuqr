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

    var body: some View {
        List {
            ForEach(fetchResult, id: \.self) { item in
                NavigationLink(destination: DetailView(code: selectedItem), tag: item, selection: $selectedItem) {
                    HStack {
                        Image(systemName: item.icon ?? "qrcode")
                        Text(item.title ?? "")
                    }
                }
            }
        }
        .navigationBarTitle("LemuQR")
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView().environmentObject(QRCodesViewModel())
    }
}
