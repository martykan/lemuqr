//
//  MainContentView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 10.04.2022.
//

import SwiftUI

/**
 Main view of the app with navigation
 */
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

// MARK: Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
