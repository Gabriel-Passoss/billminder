//
//  SubscriptionsView.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 07/03/25.
//

import SwiftUI

struct SubscriptionsView: View {
    let subscriptions: [Subscription]
    
    var body: some View {
        NavigationStack {
            List(subscriptions) { subscription in
                HStack(spacing: 16) {
                    Image(subscription.serviceImage ?? "")
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
                                Text(dateFormatter(date: subscription.dueDate))
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
                            Button(role: .destructive, action: { }, label: {
                                Image(systemName: "trash")
                            })
                            .foregroundStyle(.red)
                            
                            Button(action: { }, label: {
                                Image(systemName: "pencil")
                            })
                            .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.all, 4)
                .frame(width: .infinity, height: 80)
            }
            .navigationTitle("Subscriptions")
            .toolbar {
                Button(action: { }) {
                    Image(systemName: "plus")
                }
            }
        }
        
    }
}

#Preview {
    SubscriptionsView(subscriptions: Subscription.sample)
}
