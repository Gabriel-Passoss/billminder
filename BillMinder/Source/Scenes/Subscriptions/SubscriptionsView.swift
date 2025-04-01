//
//  SubscriptionsView.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 07/03/25.
//

import SwiftUI

struct SubscriptionsView: View {
    @State private var isAddSubcriptionBottomSheetVisible: Bool = false
    @State private var isEditSubcriptionBottomSheetVisible: Bool = false
    @State private var editingSubscription: Subscription?
    
    @StateObject var viewModel: SubscriptionsViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.subscriptions) { subscription in
                HStack(spacing: 16) {
                    subscription.serviceImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(subscription.service)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        HStack {
                            HStack(spacing: 4) {
                                Image(systemName: "calendar")
                                Text("\(subscription.dueDay)")
                            }
                            
                            HStack(spacing: 4) {
                                Text(subscription.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "person.fill")
                                Text("\(Calendar.current.dateComponents([.month], from: subscription.subscriberSince, to: Date.now).month ?? 0) months")
                            }
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive, action: {
                                if let index = viewModel.subscriptions.firstIndex(where: { $0.id == subscription.id}) {
                                    viewModel.removeSubscription(at: index)
                                }
                            }, label: {
                                Image(systemName: "trash")
                            })
                            .foregroundStyle(.red)
                            
                            Button(action: {
                                editingSubscription = subscription
                                isEditSubcriptionBottomSheetVisible = true
                            }, label: {
                                Image(systemName: "pencil")
                            })
                            .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.all, 4)
            }
            .navigationTitle("Subscriptions")
            .toolbar {
                Button(action: {
                    isAddSubcriptionBottomSheetVisible = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddSubcriptionBottomSheetVisible) {
                ManageSubscriptionSheetView(addSubscription: viewModel.addSubscription)
                    .presentationDetents([.medium])
            }
            .sheet(item: $editingSubscription) {
                editingSubscription = nil
            } content: { subscription in
                ManageSubscriptionSheetView(subscription: subscription, editSubscription: viewModel.editSubscription)
                    .presentationDetents([.medium])
            }

            
            Spacer()
            
            Text("^[\(viewModel.subscriptions.count) services](inflect: true)")
                .font(.callout)
        }
        
    }
}

#Preview {
    SubscriptionsView(viewModel: SubscriptionsViewModel(subscriptions: Subscription.sample))
}
