//
//  LemuQRApp.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 10.04.2022.
//

import SwiftUI

@main
struct LemuQRApp: App {
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, CoreDataManager.instance.persistentContainer.viewContext)
                .onAppear {
                    addTestData()
                }
        }
    }
    
    private func addTestData() {
        let request = QRCode.fetchRequest()
        let context = CoreDataManager.instance.persistentContainer.viewContext
        do {
            if try context.count(for: request) == 0 {
                try QRCode.generateTestData(in: context)
            }
        } catch {
            print("Error generating test data: \(error)")
        }
    }
}
