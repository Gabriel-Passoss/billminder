//
//  AddSubscriptionView.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 10/03/25.
//

import SwiftUI
import PhotosUI

struct AddSubscriptionView: View {
    @State private var serviceName = ""
    @State private var price = 0.00
    @State private var dueDay = 1
    @State private var memberSince = Date()
    @State private var serviceImage: PhotosPickerItem?
    @State private var pickedServiceImage: Image?
    
    var body: some View {
        Form {
            Section(header: Text("Name of service")) {
                TextField(text: $serviceName, label: {
                    Text("ex: Netflix")
                })
            }
            .padding(.top, 8)
            
            Section(header: Text("Price")) {
                TextField("Amount", value: $price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Due date")) {
                Picker("Select a day", selection: $dueDay) {
                    ForEach(1...31, id: \.self) { day in
                        Text("\(day)").tag(day)
                    }
                }
            }
            
            Section(header: Text("Subscribed since")) {
                DatePicker("Please enter a date", selection: $memberSince, displayedComponents: .date)
            }
            
            Section(header: Text("Service image")) {
                PhotosPicker(selection: $serviceImage, matching: .images) {
                    HStack {
                        Text("Select a photo")
                        
                        Spacer()
                        
                        pickedServiceImage?
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 50, height: 50)
                    }
                }
                .onChange(of: serviceImage) {
                    Task {
                        if let loaded = try? await serviceImage?.loadTransferable(type: Image.self) {
                            pickedServiceImage = loaded
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
            }
            
            Button {
                
            } label: {
                Text("Add service")
            }
            .frame(width: 300)
        }
    }
}

#Preview {
    AddSubscriptionView()
}
