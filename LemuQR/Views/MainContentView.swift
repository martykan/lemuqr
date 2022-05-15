//
//  MainContentView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 10.04.2022.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            MasterView()
            DetailView()
        }
        .navigationViewStyle(.columns)
        .environmentObject(QRCodesViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
