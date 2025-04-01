//
//  AddSubscriptionView.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 10/03/25.
//

import SwiftUI
import PhotosUI

struct ManageSubscriptionSheetView: View {
    private var subscriptionID: UUID?
    @State private var serviceName = ""
    @State private var price = 0.00
    @State private var dueDay = 1
    @State private var memberSince = Date()
    @State private var serviceImage: Image?
    @State private var pickedServiceImage: PhotosPickerItem?
    
    @Environment(\.dismiss) private var dismiss
    
    var addSubscription: ((_ subscription: Subscription) -> Void)?
    var editSubscription: ((_ subscription: Subscription) -> Void)?
    
    init(subscription: Subscription, editSubscription: @escaping (_ subscription: Subscription) -> Void) {
        self.subscriptionID = subscription.id
        _serviceName = State(initialValue: subscription.service)
        _price = State(initialValue: subscription.price)
        _dueDay = State(initialValue: subscription.dueDay)
        _memberSince = State(initialValue: subscription.subscriberSince)
        _serviceImage = State(initialValue: subscription.serviceImage)
        self.editSubscription = editSubscription
        self.addSubscription = nil
    }
    
    init(addSubscription: @escaping (_ subscription: Subscription) -> Void) {
        self.serviceName = ""
        self.price = 0.00
        self.dueDay = 1
        self.memberSince = Date()
        self.serviceName = ""
        self.pickedServiceImage = nil
        self.addSubscription = addSubscription
        self.editSubscription = nil
    }
    
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
                PhotosPicker(selection: $pickedServiceImage, matching: .images) {
                    HStack {
                        Text("Select a photo")
                        
                        Spacer()
                        
                        serviceImage?
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 50, height: 50)
                    }
                }
                .onChange(of: pickedServiceImage) {
                    Task {
                        if let loaded = try? await pickedServiceImage?.loadTransferable(type: Image.self) {
                            serviceImage = loaded
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
            }
            
            Button {
                if let addSubscription {
                    addSubscription(Subscription.init(service: serviceName, serviceImage: serviceImage ?? Image("service-placeholder"), price: price, dueDay: dueDay, since: memberSince, actualMonthPaid: false))
                }
                
                if let editSubscription {
                    editSubscription(Subscription.init(id: subscriptionID, service: serviceName, serviceImage: serviceImage ?? Image("service-placeholder"), price: price, dueDay: dueDay, since: memberSince, actualMonthPaid: false))
                }
                
                dismiss()
            } label: {
                if addSubscription != nil {
                    Text("Add service")
                } else {
                    Text("Edit service")
                }
                
            }
            .frame(width: 300)
        }
    }
}

#Preview {
    let viewModel = SubscriptionsViewModel(subscriptions: [])
    ManageSubscriptionSheetView(addSubscription: viewModel.addSubscription)
}
