//
//  AddSubscriptionView.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 10/03/25.
//

import SwiftUI
import PhotosUI
import UIKit

struct ManageSubscriptionSheetView: View {
    private var subscriptionID: UUID?
    @State private var serviceName = ""
    @State private var price = 0.00
    @State private var dueDay = 1
    @State private var memberSince = Date()
    @State private var serviceImage: ServiceImageView?
    @State private var pickedServiceImage: PhotosPickerItem?
    
    @State private var isLoading = false
    @State private var showInvalidServiceName = false
    @State private var showInvalidPriceError = false
    @State private var showInvalidServiceImage = false

    
    @Environment(\.dismiss) private var dismiss
    
    var saveSubscription: (_ subscription: Subscription) -> Void
    
    init(subscription: Subscription, saveSubscription: @escaping (_ subscription: Subscription) -> Void) {
        self.subscriptionID = subscription.id
        _serviceName = State(initialValue: subscription.service)
        _price = State(initialValue: subscription.price)
        _dueDay = State(initialValue: subscription.dueDay)
        _memberSince = State(initialValue: subscription.subscriberSince)
        _serviceImage = State(initialValue: ServiceImageView(path: subscription.serviceImage))
        self.saveSubscription = saveSubscription
    }
    
    init(saveSubscription: @escaping (_ subscription: Subscription) -> Void) {
        self.serviceName = ""
        self.price = 0.00
        self.dueDay = 1
        self.memberSince = Date()
        self.serviceName = ""
        self.pickedServiceImage = nil
        self.saveSubscription = saveSubscription
    }
    
    func handleSaveSubscription() {
        Task {
            if let pickedServiceImage = pickedServiceImage {
                if let photoData = try await pickedServiceImage.loadTransferable(type: Data.self) {
                    do {
                        let photoURL = try await StorageManager.shared.uploadPhoto(photoData, fileName: serviceName)
                        
                        let subscriptionToSave = Subscription(service: serviceName, serviceImage: photoURL.path, price: price, dueDay: dueDay, since: memberSince, actualMonthPaid: false)
                        
                        saveSubscription(subscriptionToSave)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name of service")) {
                TextField(text: $serviceName, label: {
                    Text("ex: Netflix")
                })
                .modifier(FormError(errorMessage: showInvalidServiceName ? "Enter a valid name of service" : nil))
            }
            .padding(.top, 8)
            
            Section(header: Text("Price")) {
                TextField("Amount", value: $price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .modifier(FormError(errorMessage: showInvalidPriceError ? "Price cannot be empty" : nil))
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
                PhotosPicker(selection: $pickedServiceImage, matching: .images) {
                    HStack {
                        Text("Select a photo")
                        
                        Spacer()
                        
                        serviceImage
                    }
                    .modifier(FormError(errorMessage: showInvalidServiceImage ? "Please select an image" : nil))
                }
                .onChange(of: pickedServiceImage) {
                    Task {
                        if let loaded = try await pickedServiceImage?.loadTransferable(type: Data.self) {
                            serviceImage = ServiceImageView(imageData: loaded)
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
            }
            
            Button {
                if serviceName.isEmpty {
                    showInvalidServiceName = true
                    return
                }
                
                if price == 0.00 {
                    showInvalidPriceError = true
                    return
                }
                
                if pickedServiceImage == nil {
                    showInvalidServiceImage = true
                    return
                }
                
                isLoading.toggle()
                handleSaveSubscription()
                isLoading.toggle()
                dismiss()
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Save subscription")
                }
            }
            .frame(width: 300)
        }
    }
}

#Preview {
    let viewModel = SubscriptionsViewModel(subscriptions: [])
    ManageSubscriptionSheetView(saveSubscription: viewModel.saveSubscription)
}
