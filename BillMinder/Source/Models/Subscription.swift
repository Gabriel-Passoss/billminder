//
//  Subscription.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 07/03/25.
//

import SwiftUI
import SwiftData

final class Subscription: Identifiable {
    var id: UUID
    var service: String
    var serviceImage: String
    var price: Double
    var dueDay: Int
    var subscriberSince: Date
    var actualMonthPaid: Bool = false
    
    init(id: UUID? = nil, service: String, serviceImage: String, price: Double, dueDay: Int, since subscriberSince: Date, actualMonthPaid: Bool) {
        self.id = id ?? UUID()
        self.service = service
        self.serviceImage = serviceImage
        self.price = price
        self.dueDay = dueDay
        self.subscriberSince = subscriberSince
        self.actualMonthPaid = actualMonthPaid
    }
}

extension Subscription {
    static var sample: [Subscription] {
        [
            .init(
                service: "Discord",
                serviceImage: "discord-logo.png",
                price: 24.50,
                dueDay: Int.random(in: 1...31),
                since: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date(),
                actualMonthPaid: true
            ),
            .init(
                service: "Spotify",
                serviceImage: "spotify-logo.png",
                price: 19.90,
                dueDay: Int.random(in: 1...31),
                since: Calendar.current.date(byAdding: .month, value: -9, to: Date()) ?? Date(),
                actualMonthPaid: false
            ),
            .init(
                service: "HBO Max",
                serviceImage: "hbo-logo.png",
                price: 45.00,
                dueDay: Int.random(in: 1...31),
                since: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(),
                actualMonthPaid: true
            ),
        ]
    }
}
