//
//  SubscriptionsViewModel.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 11/03/25.
//

import Foundation

class SubscriptionsViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = []
}
