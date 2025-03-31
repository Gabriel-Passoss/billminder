//
//  ContentView.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 07/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                
            }
            .tabItem {
                Image(systemName: "chart.pie")
                Text("Metrics")
            }
            
            SubscriptionsView(viewModel: SubscriptionsViewModel(subscriptions: []))
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Subscriptions")
                }
        }
    }
}

#Preview {
    ContentView()
}
