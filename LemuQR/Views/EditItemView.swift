//
//  MasterView.swift
//  LemuQR
//
//  Created by Tomáš Martykán on 11.05.2022.
//

import SwiftUI
import CoreData
import SymbolPicker

/**
 View with editing form for the code
 */
struct EditItemView: View {
    @EnvironmentObject private var viewModel: QRCodesViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentation
    
    @State private var codeType: QRCodeType = QRCodeType.QR
    @State private var title: String = ""
    @State private var icon: String = ""
    @State private var color = Color.black
    @State private var content: String = ""
    
    @State private var iconPickerPresented = false
    
    var objectId: NSManagedObjectID?
    
    var body: some View {
        VStack {
            Form {
                Section("Info") {
                    TextField("Title", text: $title)
                    Button(action: {
                        iconPickerPresented = true
                    }) {
                        HStack {
                            Text("Icon")
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(color)
                                    .frame(width: 30, height: 30)
                                Image(systemName: icon)
                                    .foregroundColor(Color.white)
                            }
                        }
                    }.buttonStyle(PlainButtonStyle())
                    ColorPicker("Color", selection: $color)
                }
                Section("Content") {
                    Picker("Code type", selection: $codeType) {
                        Text("QR").tag(QRCodeType.QR)
                        Text("Code128").tag(QRCodeType.CODE128)
                        Text("PDF417").tag(QRCodeType.PDF417)
                        Text("Aztec").tag(QRCodeType.AZTEC)
                    }.pickerStyle(.segmented)
                    TextField("Stored text/URL", text: $content)
                    Button(action: {
                        saveData()
                    }) {
                        Text("Save").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                }
            }
            .navigationTitle(objectId == nil ? "New code" : "Edit code")
            .sheet(isPresented: $iconPickerPresented) {
                SymbolPicker(symbol: $icon)
            }
            .onAppear {
                guard
                    let _objectId = objectId,
                    let qrCode = viewModel.fetchCode(for: _objectId, context: viewContext)
                else {
                    return
                }
                DispatchQueue.main.async {
                    codeType = QRCodeType(rawValue: qrCode.type) ?? QRCodeType.QR
                    title = qrCode.title ?? ""
                    content = qrCode.content ?? ""
                    icon = qrCode.icon ?? "qrcode"
                    color = Color.decode(qrCode.color)
                }
            }
        }
    }
    
    func saveData() {
        let values = QRCodeValues(
            type: codeType,
            icon: icon,
            color: color,
            title: title,
            content: content
        )
        viewModel.saveCode(
            objectId: objectId,
            with: values,
            in: viewContext)
        presentation.wrappedValue.dismiss()
    }
}

// MARK: Previews
struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView()
    }
}
