//
//  SubscriptionsViewModel.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 11/03/25.
//

import SwiftUI

final class SubscriptionsViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = []
    
    init(subscriptions: [Subscription]) {
        self.subscriptions = subscriptions
    }
    
    func addSubscription(subscription: Subscription) {
        subscriptions.append(subscription)
    }
}
