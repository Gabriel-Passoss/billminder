//
//  SubscriptionsViewModel.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 11/03/25.
//

import SwiftUI

final class SubscriptionsViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = []
    
    init(subscriptions: [Subscription]?) {
        self.subscriptions = subscriptions ?? []
    }
    
    func removeSubscription(at index: Int) {
        subscriptions.remove(at: index)
    }
    
    func saveSubscription(subscription: Subscription) {
        if let index = subscriptions.firstIndex(where: { $0.id == subscription.id}) {
            subscriptions[index] = subscription
            return
        }
        
        subscriptions.append(subscription)
    }
}
