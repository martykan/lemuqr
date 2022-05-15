//
//  ContentView.swift
//  LemuQR WatchKit Extension
//
//  Created by Tomáš Martykán on 10.04.2022.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            MasterView()
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
