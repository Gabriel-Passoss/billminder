//
//  Subscription.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 07/03/25.
//

import Foundation

class Subscription: Identifiable {
    let id = UUID()
    let service: String
    let serviceImage: String?
    let price: Double
    let dueDate: Date
    var subscriberSince: Date
    var actualMonthPaid: Bool = false
    
    init(service: String, serviceImage: String? = nil, price: Double, dueDate: Date, since subscriberSince: Date, actualMonthPaid: Bool) {
        self.service = service
        self.serviceImage = serviceImage
        self.price = price
        self.dueDate = dueDate
        self.subscriberSince = subscriberSince
        self.actualMonthPaid = actualMonthPaid
    }
}

extension Subscription {
    static var sample: [Subscription] {
        [
            .init(
                service: "Discord",
                serviceImage: "discord-logo",
                price: 24.50,
                dueDate: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                since: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date(),
                actualMonthPaid: true
            ),
            .init(
                service: "Spotify",
                serviceImage: "spotify-logo",
                price: 19.90,
                dueDate: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
                since: Calendar.current.date(byAdding: .month, value: -9, to: Date()) ?? Date(),
                actualMonthPaid: false
            ),
            .init(
                service: "Raycast",
                serviceImage: "hbo-max-logo",
                price: 45.00,
                dueDate: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
                since: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(),
                actualMonthPaid: true
            ),
        ]
    }
}
